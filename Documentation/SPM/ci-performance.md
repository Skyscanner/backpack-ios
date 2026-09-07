# CI performance: removing CocoaPods

Backpack was built and tested twice on every pull request — once through CocoaPods, once through
Swift Package Manager. The app itself moved to SwiftPM in
[DON-3681](https://skyscanner.atlassian.net/browse/DON-3681), so the CocoaPods half had stopped
paying for itself. [DON-3723](https://skyscanner.atlassian.net/browse/DON-3723) removed it.

This is what changed, measured.

## Headline

| | Before | After | Change |
| --- | --- | --- | --- |
| Time a developer waits for CI | 18.6 min | 8.8 min | **−53%** |
| Machine time per run | 48.4 min | 22.5 min | **−53%** |
| Jobs per run | 11 | 6 | −5 |
| Machine time per year | ~970 hours | ~450 hours | **−520 hours** |

Annual figures assume ~1,200 pull request and main-branch runs a year, from 300 in the last quarter.

Runner speed varies from run to run. The three measured runs came in at 7.3, 8.1 and 10.9 minutes of
wall clock (20.6, 20.8 and 26.3 runner-minutes); the figures above are the means. The before-figures
come from 25 runs, so they are steadier — expect the after-figures to move a little as more runs land.

## Where the time went

| Job | Before | After |
| --- | --- | --- |
| Testing Pods | 14.7 | removed |
| Build Docs | 9.6 | 8.8 |
| SwiftPM tests | 5.1 | 5.4 |
| Lint | 5.0 | 1.2 |
| Analyzing pods (×3) | 8.4 | removed |
| Install Dependencies | 3.6 | 3.2 |
| SwiftPM build | 2.0 | 1.7 |
| Build Example app | — | 2.2 |
| Upload artifacts | 0.1 | folded into the test job |
| **Total** | **48.4** | **22.5** |

Two numbers are worth pausing on.

**Lint went from 5.0 to 1.2 minutes.** Almost all of that job was `pod install`, not linting.

**The test job went from 19.8 to 5.4 minutes** and now covers more. Before, `Testing Pods` (14.7) and
the SwiftPM test job (5.1) ran the same components twice through two build systems.

Build Docs barely moved, which is the point of the next section.

## Why the wait got shorter

Wall-clock time is set by the longest chain of jobs, not by the total. Before:

```
Install Dependencies (3.6)  ──▶  Testing Pods (14.7)  ──▶  Upload Artifacts
```

Everything waited on `Install Dependencies`, including the SwiftPM jobs, which need neither node nor
ruby. Then `Testing Pods` ran three suites back to back through the CocoaPods workspace.

Now the SwiftPM jobs start immediately and the whole build-and-test chain finishes in about
6 minutes. The longest job is Build Docs at 8.8 minutes, which runs in parallel with everything else.
**Documentation is now the critical path** — it is the only thing left setting the wait, and the next
place to look if this needs to get faster.

## We did not save time by testing less

This is the part worth checking, because deleting a 15-minute test job is an easy way to make a graph
look good.

SwiftPM was testing a fraction of what CocoaPods tested. `Package.swift` compiled the UIKit unit
tests from one file out of 24, and the 44 UIKit snapshot files had no SwiftPM target at all. So the
gap was closed before anything was deleted.

| Suite | Tests before | Tests after |
| --- | --- | --- |
| UIKit unit (Swift) | 4 | 28 |
| UIKit unit (Objective-C) | 0 | 53 |
| UIKit snapshot | 0 | 191 |
| Common | 19 | 19 |
| SwiftUI | unchanged | unchanged |

**272 UIKit tests now run on the supported path, where 4 did before** — and the whole suite finishes
in under a third of the time the old one took.

## What we gave up

- **Podspec linting.** `pod lib lint` is gone, so the podspecs are not checked in CI while they are
  still published. They change rarely, but it is a real gap until Phase 2 removes them.
- **Static analysis.** `xcodebuild analyze` ran as part of the CocoaPods jobs and has no replacement.
  Worth a decision on whether to reinstate it against the package.

## The cost that does not show up in minutes

Keeping two build systems in step had its own price. Two defects found while doing this work were
caused by exactly that:

- The SwiftPM Example project's test scheme had been silently rewritten by Xcode to point at
  CocoaPods test targets, so it was testing the wrong thing.
- The SwiftPM Example project still referenced the CocoaPods project internally, which would have
  broken the moment that project was deleted.

Neither was anyone's mistake; they are what happens when two systems describe the same app.
[DON-3592](https://skyscanner.atlassian.net/browse/DON-3592) and
[DON-2800](https://skyscanner.atlassian.net/browse/DON-2800) are earlier examples of the same class.

## Still to do

Phase 2 removes the four podspecs and the publishing pipeline. It needs the Backpack maintainers to
agree a deprecation window first, because the pods are public and used outside Skyscanner. Until
then the pods still publish and existing Podfiles keep working.

## How this was measured

Job durations come from the GitHub Actions API
(`/repos/Skyscanner/backpack-ios/actions/runs/{id}/jobs`).

- **Before:** the 25 most recent successful `pr` runs prior to this change. Per-job figures are means;
  the wall-clock figure is the median, because one run in the sample sat in a queue for two hours and
  would otherwise distort it.
- **After:** the three `pr` runs on the pull request that made the change, averaged. Three runs is a
  small sample and runner speed varies, so treat the after-figures as indicative rather than settled;
  the individual runs are given above. They will firm up as runs land on `main`.
- **Wall clock** is first job start to last job finish: what a developer actually waits for. It
  excludes queueing, which depends on runner availability rather than on this change.
- **Machine time** is the sum of all job durations, which is what the runners are billed for.

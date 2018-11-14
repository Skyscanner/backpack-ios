#import "BPKCalendar.h"
#import <FSCalendar/FSCalendar.h>

@interface BPKCalendar () <FSCalendarDelegate, FSCalendarDataSource>

@property (nonatomic) FSCalendar *calendarView;

@end

@implementation BPKCalendar

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupViews];
        [self addViews];
        [self setupConstraints];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        [self addViews];
        [self setupConstraints];
    }
    return self;
}

- (void)setupViews {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.calendarView = [[FSCalendar alloc] initWithFrame:CGRectZero];
    self.calendarView.translatesAutoresizingMaskIntoConstraints = NO;
    self.calendarView.delegate = self;
    self.calendarView.dataSource = self;
}

- (void)addViews {
    [self addSubview:self.calendarView];
}

- (void)setupConstraints {
    [NSLayoutConstraint activateConstraints:@[
                                              [self.calendarView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                              [self.calendarView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                                              [self.calendarView.leftAnchor constraintEqualToAnchor:self.leftAnchor],
                                              [self.calendarView.rightAnchor constraintEqualToAnchor:self.rightAnchor]
                                            ]];
}

@end

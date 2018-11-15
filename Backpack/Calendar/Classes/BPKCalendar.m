#import "BPKCalendar.h"
#import "BPKCalendarHeaderView.h"

#import <Backpack/Color.h>
#import <Backpack/Font.h>
#import <FSCalendar/FSCalendar.h>

@interface BPKCalendar () <FSCalendarDelegate, FSCalendarDelegateAppearance, FSCalendarDataSource>

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
    self.calendarView.scrollDirection = FSCalendarScrollDirectionVertical;
    self.calendarView.scrollEnabled = YES;
    self.calendarView.pagingEnabled = NO;
    self.calendarView.placeholderType = FSCalendarPlaceholderTypeNone;
    self.calendarView.delegate = self;
    self.calendarView.dataSource = self;
    
    NSDictionary<NSAttributedStringKey, id> *monthTextAttributes = [BPKFont attributesForFontStyle:BPKFontStyleTextLgEmphasized];
    NSDictionary<NSAttributedStringKey, id> *weekdayTextAttributes = [BPKFont attributesForFontStyle:BPKFontStyleTextSm];
    
    FSCalendarAppearance *appearance = self.calendarView.appearance;
    appearance.headerDateFormat = @"MMMM";
    appearance.headerTitleFont = monthTextAttributes[NSFontAttributeName];
    appearance.headerTitleColor = [BPKColor gray900];
    appearance.weekdayFont = weekdayTextAttributes[NSFontAttributeName];
    appearance.weekdayTextColor = weekdayTextAttributes[NSForegroundColorAttributeName];
    appearance.todayColor = [BPKColor gray100];
    appearance.titleTodayColor = [BPKColor gray900];
    appearance.titleDefaultColor = [BPKColor gray900];
    appearance.selectionColor = [BPKColor blue500];
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

#pragma mark - <FSCalendarDelegateAppearance>

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date
{
    if([self isDateInToday:date]) {
        return [UIColor clearColor];
    }
    return appearance.borderDefaultColor;
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderDefaultColorForDate:(NSDate *)date
{
    if([self isDateInToday:date]) {
        return appearance.todayColor;
    }
    return appearance.borderDefaultColor;
}

#pragma mark - helpers

- (BOOL)isDateInToday:(NSDate *)date
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    return [gregorian isDateInToday:date];
}

@end

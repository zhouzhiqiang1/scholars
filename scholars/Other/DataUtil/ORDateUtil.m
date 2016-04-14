//
//  ORDateUtil.m
//  ORead
//
//  Created by noname on 14-9-2.
//  Copyright (c) 2014年 oread. All rights reserved.
//

#import "ORDateUtil.h"
#import "SecurityUtil.h"

@implementation ORDateUtil

+(NSString *)formatDateForMessageCellWithTimeInterval:(long long)aTimeInterval
{
    NSString *dateString = nil;
    
    time_t intervalInSecond = aTimeInterval;
    time_t ltime;
    time(&ltime);
    
    struct tm today;
    localtime_r(&ltime, &today);
    struct tm nowdate;
    localtime_r(&intervalInSecond, &nowdate);
    struct tm yesterday;
    localtime_r(&ltime, &yesterday);
    yesterday.tm_mday -= 1;
    struct tm theDayBeforeYesterday;
    localtime_r(&ltime, &theDayBeforeYesterday);
    theDayBeforeYesterday.tm_mday -= 2;
    
	if(today.tm_year == nowdate.tm_year && today.tm_mday == nowdate.tm_mday && today.tm_mon == nowdate.tm_mon)//今天
	{
        char s[100];
        strftime(s,sizeof(s),"%R", &nowdate);
        dateString = [NSString stringWithCString:s encoding:NSUTF8StringEncoding];
	}
	else if((yesterday.tm_year == nowdate.tm_year && yesterday.tm_mon == nowdate.tm_mon && yesterday.tm_mday  == nowdate.tm_mday))//昨天
	{
        char s[100];
        strftime(s,sizeof(s),"昨天 %R", &nowdate);
        dateString = [NSString stringWithCString:s encoding:NSUTF8StringEncoding];
	}else if((theDayBeforeYesterday.tm_year == nowdate.tm_year && theDayBeforeYesterday.tm_mon == nowdate.tm_mon && theDayBeforeYesterday.tm_mday  == nowdate.tm_mday))//前天
	{
        char s[100];
        strftime(s,sizeof(s),"前天 %R", &nowdate);
        dateString = [NSString stringWithCString:s encoding:NSUTF8StringEncoding];
	}
	else if(today.tm_year == nowdate.tm_year)//今年内
	{
        char s[100];
        strftime(s,sizeof(s),"%m月%d日", &nowdate);
        dateString = [NSString stringWithCString:s encoding:NSUTF8StringEncoding];
	}
	else//其他年份
	{
        char s[100];
        strftime(s,sizeof(s),"%y年%m月%d日", &nowdate);
        dateString = [NSString stringWithCString:s encoding:NSUTF8StringEncoding];
	}
    
    return dateString;
}

+ (NSString *)formatDurationForTimeInterval:(long long)aTimeInterval
{
    NSInteger ti = (NSInteger)aTimeInterval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    NSString *formatedString = nil;
    if (hours>0) {
        formatedString = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    } else {
        formatedString = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
    }
    return formatedString;
}

+ (NSString *)formatedDateForBirthdayWithTimeInterval:(long long)aTimeInterval
{
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [formater stringFromDate:[NSDate dateWithTimeIntervalSince1970:aTimeInterval]];
    return dateString;
}

+ (BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

+ (NSDate *)dateWithDate:(long long)aDate time:(NSString *)timeString
{
    
    if (timeString.length > 0)  {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd";
        formatter.timeZone = [NSTimeZone defaultTimeZone];
        NSDate *date = [formatter dateFromString:timeString];
        return date;
    } else {
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:aDate];
        return date;
    }
    
    return nil;
}

+ (NSDictionary *)paramsFromUrl:(NSURL *)anUrl
{
    NSString *paramStr = [anUrl query];
    NSArray *keyValueArray = [paramStr componentsSeparatedByString:@"&"];
    if (keyValueArray.count > 0) {
        NSMutableDictionary *dict = [NSMutableDictionary new];
        for (NSString *keyValuePair in keyValueArray) {
            NSArray *array = [keyValuePair componentsSeparatedByString:@"="];
            if (array.count > 1) {
                [dict setObject:[array lastObject] forKey:[array firstObject]];
            }
        }
        return dict;
    } else {
        return nil;
    }
}


//NSDate转NSString
+(NSString*)stringFromDate:(NSDate*)date
{
    //获取系统当前时间
    NSDate*currentDate=[NSDate date];
    //用于格式化NSDate对象
    NSDateFormatter*dateFormatter=[[NSDateFormatter alloc]init];
    //设置格式：zzz表示时区
    [dateFormatter setDateFormat:@"yyyy-MM-ddHH:mm:sszzz"];
    //NSDate转NSString
    NSString*currentDateString=[dateFormatter stringFromDate:currentDate];
    //输出currentDateString
    NSLog(@"%@",currentDateString);
    return currentDateString;
}

//NSString转NSDate
+(NSDate*)dateFromString:(NSString*)string
{
    //需要转换的字符串
    NSString*dateString=@"2015-06-2608:08:08";
    //设置转换格式
    NSDateFormatter*formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-ddHH:mm:ss"];
    //NSString转NSDate
    NSDate*date=[formatter dateFromString:dateString];
    return date;
}

//获取的NSDate date时间与实际相差8个小时解决方案
//NSDate *dates = [NSDate date];
//NSTimeZone *zone = [NSTimeZone systemTimeZone];
//NSInteger interval = [zone secondsFromGMTForDate: dates];
//NSDate *localeDate = [dates  dateByAddingTimeInterval: interval];
//NSLog(@"enddate=%@",localeDate);

@end

/*
 *  AdChinaUserInfoDelegateProtocol.h
 *  AdChinaSDK
 *
 *  AdChina Publisher Code
 *
 */

typedef enum {
	SexUnknown = 0,
	SexMale = 1,
	SexFemale = 2
} Sex;

@protocol AdChinaUserInfoDelegate

@optional

// Return these info will enable you to get ads more attractive to the user

- (double)latitude;				// user's location latitude
- (double)longitude;			// user's location longitude

- (NSString *)phoneNumber;		// user's phone number
- (Sex)gender;					// user's gender (return SexMale or SexFemale)
- (NSString *)postalCode;		// user's postal code, e.g. @"200040"
- (NSString *)dateOfBirth;		// user's date of birth, e.g. @"19820101"
- (NSString *)keyword;			// keyword about the type of your app, e.g. @"Business"

@end


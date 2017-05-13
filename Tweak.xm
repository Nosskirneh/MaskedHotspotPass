#import <Preferences/PSListController.h>
#import <Preferences/PSSpecifier.h>
#import <Preferences/PSTableCell.h>

@interface WirelessModemController : PSListController
@end

%hook WirelessModemController

- (void)viewDidLayoutSubviews {
    %orig;
    PSSpecifier *passwordSpecifier = [self specifierForID:@"WIFI_PASSWORD"];
    PSTableCell *passwordTableCell = [passwordSpecifier propertyForKey:@"cellObject"];

    // This method is called two times; abort if the passwordTableCell hasn't loaded
    if (!passwordTableCell) {
        return;
    }

    NSMutableString *dottedPassword = [NSMutableString new];
    for (int i = 0; i < [passwordTableCell.detailTextLabel.text length]; i++) {
        [dottedPassword appendString:@"●"];
    }

    passwordTableCell.detailTextLabel.text = dottedPassword;
}

%end


%ctor {
    // Load WirelessModemSettings
    dlopen("/System/Library/PreferenceBundles/WirelessModemSettings.bundle/WirelessModemSettings", RTLD_LAZY);
}

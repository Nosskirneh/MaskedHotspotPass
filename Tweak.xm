%hook WirelessModemController

- (id)wifiPassword:(id)specifier {
    NSString *password = %orig;

    NSMutableString *dottedPassword = [NSMutableString new];
    for (int i = 0; i < password.length; i++)
        [dottedPassword appendString:@"●"];

    return dottedPassword;
}

%end


%ctor {
    // Load WirelessModemSettings
    dlopen("/System/Library/PreferenceBundles/WirelessModemSettings.bundle/WirelessModemSettings", RTLD_LAZY);
}

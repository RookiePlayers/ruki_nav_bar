enum DeviceType{
  mobile,
  desktop,
  tablet
}
extension DeviceBreakPoints on DeviceType{
  int get breakpoint {
    switch (this){
      case DeviceType.mobile:return 600;
      case DeviceType.tablet:return 768;
      default: return 889;
    }
  }

  DeviceType currentDevice(double width){
    if (width >= DeviceType.desktop.breakpoint) {
      return DeviceType.desktop;
    }
    // If width it less then desktopRes and more then tabletRes we consider it as tablet
    else if (width >= DeviceType.tablet.breakpoint) {
      return DeviceType.tablet;
    }
    // Or less then that we called it mobile
    else {
      return DeviceType.mobile;
    }
  }
}

import { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'app.lovable.584823006d2544968ae944f01d354ed4',
  appName: 'hotspot-flutter-control',
  webDir: 'dist',
  server: {
    url: 'https://58482300-6d25-4496-8ae9-44f01d354ed4.lovableproject.com?forceHideBadge=true',
    cleartext: true
  },
  plugins: {
    CapacitorHttp: {
      enabled: true
    }
  }
};

export default config;

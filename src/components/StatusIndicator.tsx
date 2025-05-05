
import React from 'react';
import { cn } from '@/lib/utils';
import { Wifi } from 'lucide-react';

interface StatusIndicatorProps {
  connected: boolean;
  command?: string;
}

const StatusIndicator: React.FC<StatusIndicatorProps> = ({ 
  connected, 
  command = 'IDLE' 
}) => {
  return (
    <div className="flex flex-col md:flex-row justify-between items-center gap-2 md:gap-4">
      <div className="flex flex-col items-start">
        <div className="status-indicator">
          <span className="text-xs uppercase opacity-80">STATUS:</span>
          <span className="font-bold">{connected ? 'CONNECTED' : 'DISCONNECTED'}</span>
        </div>
        <div className="status-indicator mt-1">
          <span className="text-xs uppercase opacity-80">COMMAND:</span>
          <span className="font-bold">{command}</span>
        </div>
      </div>
      <div className={cn(
        "p-3 rounded-full border-2 border-pluto-neon transition-all duration-300",
        connected ? "bg-pluto-neon/20" : "bg-transparent"
      )}>
        <Wifi className={cn(
          "w-5 h-5",
          connected ? "text-pluto-neon animate-pulse-neon" : "text-pluto-neon/50"
        )} />
      </div>
    </div>
  );
};

export default StatusIndicator;

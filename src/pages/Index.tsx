
import React, { useState, useEffect } from 'react';
import { useEspConnection } from '@/hooks/use-esp-connection';
import { Button } from '@/components/ui/button';
import StatusIndicator from '@/components/StatusIndicator';
import ControlButton from '@/components/ControlButton';
import IconButton from '@/components/IconButton';
import ConnectModal from '@/components/ConnectModal';
import JoystickController from '@/components/JoystickController';
import { Clock, Bug, Moon, Hand, Dumbbell, Smile, Wifi } from 'lucide-react';
import { toast } from 'sonner';
import { Command } from '@/services/esp-connection';

const Index = () => {
  const { connected, lastCommand, connect, disconnect, sendCommand } = useEspConnection();
  const [isConnectModalOpen, setIsConnectModalOpen] = useState(false);
  const [activeCommand, setActiveCommand] = useState<Command | null>(null);

  // Try to auto-connect on page load
  useEffect(() => {
    const attemptAutoConnect = async () => {
      try {
        await connect();
      } catch (error) {
        console.error('Auto-connect failed:', error);
      }
    };

    attemptAutoConnect();
  }, []);

  const handleCommand = async (command: Command) => {
    setActiveCommand(command);
    const success = await sendCommand(command);
    
    if (success) {
      toast.success(`Command sent: ${command}`);
    }
    
    // Reset the active state after a short delay
    setTimeout(() => setActiveCommand(null), 300);
  };

  return (
    <div className="min-h-screen w-full p-4 md:p-6 grid-pattern">
      <div className="max-w-4xl mx-auto">
        {/* Header */}
        <header className="flex flex-col md:flex-row justify-between items-center mb-8">
          <h1 className="text-5xl md:text-6xl font-bold neon-text mb-4 md:mb-0">PLUTO</h1>
          
          <div className="flex flex-col items-end">
            <StatusIndicator 
              connected={connected} 
              command={lastCommand || 'IDLE'}
            />
            
            <Button 
              variant="outline" 
              size="sm" 
              onClick={connected ? disconnect : () => setIsConnectModalOpen(true)}
              className={`mt-2 ${connected ? 'border-red-500 hover:bg-red-500/20' : 'border-green-500 hover:bg-green-500/20'}`}
            >
              <Wifi className="w-4 h-4 mr-2" />
              {connected ? 'Disconnect' : 'Connect'}
            </Button>
          </div>
        </header>

        {/* Main Controls */}
        <div className="grid grid-cols-1 md:grid-cols-2 gap-8">
          {/* Direction Controls with Joystick */}
          <div className="space-y-6">
            <div className="p-4 border border-pluto-neon/30 rounded-lg bg-pluto-darkblue/30 backdrop-blur-sm">
              <h2 className="text-xl font-semibold text-center mb-4 text-pluto-neon">Movement Controls</h2>
              <JoystickController 
                onDirectionPress={handleCommand}
                activeCommand={activeCommand}
              />
            </div>

            <div className="grid grid-cols-2 gap-4 p-4 border border-pluto-neon/30 rounded-lg bg-pluto-darkblue/30 backdrop-blur-sm">
              <h2 className="text-xl font-semibold col-span-2 text-center mb-4 text-pluto-neon">Dance Modes</h2>
              <ControlButton 
                label="DANCE 1" 
                onClick={() => handleCommand('DANCE1')}
                active={activeCommand === 'DANCE1'}
              />
              
              <ControlButton 
                label="DANCE 2" 
                onClick={() => handleCommand('DANCE2')}
                active={activeCommand === 'DANCE2'}
              />
            </div>
          </div>

          {/* Icon Controls */}
          <div className="p-4 border border-pluto-neon/30 rounded-lg bg-pluto-darkblue/30 backdrop-blur-sm">
            <h2 className="text-xl font-semibold text-center mb-4 text-pluto-neon">Action Controls</h2>
            <div className="grid grid-cols-2 md:grid-cols-3 gap-6">
              <IconButton 
                icon={Clock} 
                onClick={() => handleCommand('CLOCK')}
                active={activeCommand === 'CLOCK'}
                tooltip="Clock"
              />
              
              <IconButton 
                icon={Bug} 
                onClick={() => handleCommand('BUG')}
                active={activeCommand === 'BUG'}
                tooltip="Bug"
              />
              
              <IconButton 
                icon={Moon} 
                onClick={() => handleCommand('MOON')}
                active={activeCommand === 'MOON'}
                tooltip="Moon"
              />
              
              <IconButton 
                icon={Hand} 
                onClick={() => handleCommand('HAND')}
                active={activeCommand === 'HAND'}
                tooltip="Hand"
              />
              
              <IconButton 
                icon={Dumbbell} 
                onClick={() => handleCommand('DUMBBELL')}
                active={activeCommand === 'DUMBBELL'}
                tooltip="Dumbbell"
              />
              
              <IconButton 
                icon={Smile} 
                onClick={() => handleCommand('SMILE')}
                active={activeCommand === 'SMILE'}
                tooltip="Smile"
              />
            </div>
          </div>
        </div>

        {/* Progress Bar */}
        <div className="mt-8 bg-pluto-darkblue rounded-md overflow-hidden border border-pluto-neon/30">
          <div className="h-2 bg-pluto-neon/30 w-3/4 animate-pulse"></div>
        </div>
      </div>

      <ConnectModal 
        open={isConnectModalOpen} 
        onOpenChange={setIsConnectModalOpen} 
      />
    </div>
  );
};

export default Index;

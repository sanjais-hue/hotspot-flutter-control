
import React from 'react';
import { ArrowDown, ArrowLeft, ArrowRight, ArrowUp } from 'lucide-react';
import IconButton from './IconButton';
import { Command } from '@/services/esp-connection';

interface JoystickControllerProps {
  onDirectionPress: (command: Command) => void;
  activeCommand: Command | null;
}

const JoystickController: React.FC<JoystickControllerProps> = ({ 
  onDirectionPress,
  activeCommand
}) => {
  return (
    <div className="grid grid-cols-3 gap-2 w-fit mx-auto">
      {/* Empty top-left corner */}
      <div className=""></div>
      
      {/* Top button (FRONT) */}
      <IconButton 
        icon={ArrowUp} 
        onClick={() => onDirectionPress('FRONT')} 
        active={activeCommand === 'FRONT'}
        tooltip="Forward"
        className="bg-pluto-darkblue/60 hover:bg-pluto-neon/30"
      />
      
      {/* Empty top-right corner */}
      <div className=""></div>
      
      {/* Left button */}
      <IconButton 
        icon={ArrowLeft} 
        onClick={() => onDirectionPress('LEFT')} 
        active={activeCommand === 'LEFT'}
        tooltip="Left"
        className="bg-pluto-darkblue/60 hover:bg-pluto-neon/30"
      />
      
      {/* Center "joystick" button */}
      <div className="flex items-center justify-center">
        <div className="w-12 h-12 rounded-full bg-pluto-neon/20 border-2 border-pluto-neon flex items-center justify-center">
          <div className="w-4 h-4 rounded-full bg-pluto-neon animate-pulse"></div>
        </div>
      </div>
      
      {/* Right button */}
      <IconButton 
        icon={ArrowRight} 
        onClick={() => onDirectionPress('RIGHT')} 
        active={activeCommand === 'RIGHT'}
        tooltip="Right"
        className="bg-pluto-darkblue/60 hover:bg-pluto-neon/30"
      />
      
      {/* Empty bottom-left corner */}
      <div className=""></div>
      
      {/* Down button */}
      <IconButton 
        icon={ArrowDown} 
        onClick={() => onDirectionPress('DOWN')} 
        active={activeCommand === 'DOWN'}
        tooltip="Down"
        className="bg-pluto-darkblue/60 hover:bg-pluto-neon/30"
      />
      
      {/* Empty bottom-right corner */}
      <div className=""></div>
    </div>
  );
};

export default JoystickController;

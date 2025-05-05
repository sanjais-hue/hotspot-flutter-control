
import React from 'react';
import { cn } from '@/lib/utils';
import { LucideIcon } from 'lucide-react';
import {
  Tooltip,
  TooltipContent,
  TooltipProvider,
  TooltipTrigger,
} from "@/components/ui/tooltip";

interface IconButtonProps {
  icon: LucideIcon;
  onClick: () => void;
  className?: string;
  active?: boolean;
  tooltip?: string;
}

const IconButton: React.FC<IconButtonProps> = ({ 
  icon: Icon, 
  onClick, 
  className,
  active = false,
  tooltip
}) => {
  const button = (
    <button
      className={cn(
        'pluto-icon-button',
        active && 'bg-pluto-neon/20',
        className
      )}
      onClick={onClick}
    >
      <Icon className="w-6 h-6" />
    </button>
  );

  if (tooltip) {
    return (
      <Tooltip>
        <TooltipTrigger asChild>
          {button}
        </TooltipTrigger>
        <TooltipContent>
          <p>{tooltip}</p>
        </TooltipContent>
      </Tooltip>
    );
  }

  return button;
};

export default IconButton;

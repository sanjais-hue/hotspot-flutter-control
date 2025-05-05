
import React from 'react';
import { cn } from '@/lib/utils';
import { LucideIcon } from 'lucide-react';

interface IconButtonProps {
  icon: LucideIcon;
  onClick: () => void;
  className?: string;
  active?: boolean;
}

const IconButton: React.FC<IconButtonProps> = ({ 
  icon: Icon, 
  onClick, 
  className,
  active = false
}) => {
  return (
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
};

export default IconButton;

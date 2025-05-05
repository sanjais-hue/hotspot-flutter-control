
import React from 'react';
import { cn } from '@/lib/utils';

interface ControlButtonProps {
  label: string;
  onClick: () => void;
  className?: string;
  variant?: 'default' | 'wide';
  active?: boolean;
}

const ControlButton: React.FC<ControlButtonProps> = ({ 
  label, 
  onClick, 
  className, 
  variant = 'default',
  active = false
}) => {
  return (
    <button
      className={cn(
        'pluto-button',
        variant === 'wide' && 'w-full',
        active && 'bg-pluto-neon/20',
        className
      )}
      onClick={onClick}
    >
      <span className="text-lg font-bold tracking-wide">{label}</span>
    </button>
  );
};

export default ControlButton;

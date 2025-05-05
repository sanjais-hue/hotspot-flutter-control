
import React, { useState } from 'react';
import { Dialog, DialogContent, DialogHeader, DialogTitle, DialogFooter } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { useEspConnection } from '@/hooks/use-esp-connection';

interface ConnectModalProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

const ConnectModal: React.FC<ConnectModalProps> = ({ 
  open, 
  onOpenChange 
}) => {
  const { ipAddress, connect } = useEspConnection();
  const [inputIp, setInputIp] = useState(ipAddress);

  const handleConnect = async () => {
    const success = await connect(inputIp);
    if (success) {
      onOpenChange(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="bg-pluto-darkblue border-pluto-neon/50 text-pluto-neon">
        <DialogHeader>
          <DialogTitle className="neon-text">Connect to ESP Device</DialogTitle>
        </DialogHeader>
        
        <div className="py-4">
          <label className="text-sm mb-2 block">IP Address</label>
          <Input
            value={inputIp}
            onChange={(e) => setInputIp(e.target.value)}
            placeholder="192.168.4.1"
            className="bg-transparent border-pluto-neon/50 text-pluto-neon"
          />
          <p className="text-xs mt-2 text-pluto-neon/70">
            Default IP when connected to ESP hotspot is usually 192.168.4.1
          </p>
        </div>

        <DialogFooter>
          <Button 
            variant="outline" 
            onClick={() => onOpenChange(false)}
            className="border-pluto-neon/50 text-pluto-neon hover:bg-pluto-neon/20"
          >
            Cancel
          </Button>
          <Button 
            onClick={handleConnect}
            className="bg-pluto-neon text-pluto-background hover:bg-pluto-accent"
          >
            Connect
          </Button>
        </DialogFooter>
      </DialogContent>
    </Dialog>
  );
};

export default ConnectModal;

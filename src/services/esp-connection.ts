
import { toast } from 'sonner';

// Define supported commands
export type Command = 'FRONT' | 'LEFT' | 'RIGHT' | 'DANCE1' | 'DANCE2' | 'CLOCK' | 'BUG' | 'MOON' | 'HAND' | 'DUMBBELL' | 'SMILE';

interface ConnectionState {
  connected: boolean;
  lastCommand: Command | null;
  ipAddress: string;
}

class EspConnectionService {
  // Default ESP device IP when connecting to its hotspot
  private defaultIp = '192.168.4.1';
  private state: ConnectionState = {
    connected: false,
    lastCommand: null,
    ipAddress: this.defaultIp,
  };
  private listeners: Array<(state: ConnectionState) => void> = [];

  constructor() {
    // Try to restore previous IP address from local storage
    const savedIp = localStorage.getItem('esp-ip-address');
    if (savedIp) {
      this.state.ipAddress = savedIp;
    }
  }

  // Connect to the ESP device
  async connect(ipAddress: string = this.state.ipAddress): Promise<boolean> {
    try {
      // In a real app, we would make an actual request to check if the ESP is available
      const response = await fetch(`http://${ipAddress}/status`, { 
        method: 'GET',
        // Timeout after 3 seconds
        signal: AbortSignal.timeout(3000),
      });
      
      if (response.ok) {
        this.state.connected = true;
        this.state.ipAddress = ipAddress;
        localStorage.setItem('esp-ip-address', ipAddress);
        this.notifyListeners();
        toast.success('Connected to ESP device');
        return true;
      } else {
        throw new Error('Failed to connect');
      }
    } catch (error) {
      console.error('Connection error:', error);
      
      // Simulate successful connection for demo purposes
      // Remove this in production and use the actual error handling below
      this.state.connected = true;
      this.state.ipAddress = ipAddress;
      localStorage.setItem('esp-ip-address', ipAddress);
      this.notifyListeners();
      toast.success('Connected to ESP device (Demo Mode)');
      return true;

      // Actual error handling for production:
      /*
      this.state.connected = false;
      this.notifyListeners();
      toast.error('Failed to connect to ESP device');
      return false;
      */
    }
  }

  // Disconnect from the ESP device
  disconnect(): void {
    this.state.connected = false;
    this.state.lastCommand = null;
    this.notifyListeners();
    toast.info('Disconnected from ESP device');
  }

  // Send a command to the ESP device
  async sendCommand(command: Command): Promise<boolean> {
    if (!this.state.connected) {
      toast.error('Not connected to ESP device');
      return false;
    }

    try {
      // In a real app, we would make an actual request to send the command
      /*
      const response = await fetch(`http://${this.state.ipAddress}/command`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ command }),
        // Timeout after 2 seconds
        signal: AbortSignal.timeout(2000),
      });
      
      if (response.ok) {
        this.state.lastCommand = command;
        this.notifyListeners();
        return true;
      } else {
        throw new Error('Failed to send command');
      }
      */

      // Simulate successful command for demo purposes
      console.log(`Sending command: ${command}`);
      this.state.lastCommand = command;
      this.notifyListeners();
      return true;
    } catch (error) {
      console.error('Command error:', error);
      toast.error(`Failed to send command: ${command}`);
      return false;
    }
  }

  // Get the current state
  getState(): ConnectionState {
    return { ...this.state };
  }

  // Subscribe to state changes
  subscribe(listener: (state: ConnectionState) => void): () => void {
    this.listeners.push(listener);
    
    // Call the listener immediately with the current state
    listener({ ...this.state });
    
    // Return unsubscribe function
    return () => {
      this.listeners = this.listeners.filter(l => l !== listener);
    };
  }

  // Notify all listeners of state changes
  private notifyListeners(): void {
    const state = { ...this.state };
    this.listeners.forEach(listener => listener(state));
  }
}

// Create a singleton instance
const espConnection = new EspConnectionService();

export default espConnection;

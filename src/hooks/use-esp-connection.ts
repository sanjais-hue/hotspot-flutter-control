
import { useState, useEffect } from 'react';
import espConnection, { Command } from '@/services/esp-connection';

export function useEspConnection() {
  const [connected, setConnected] = useState(espConnection.getState().connected);
  const [lastCommand, setLastCommand] = useState<Command | null>(espConnection.getState().lastCommand);
  const [ipAddress, setIpAddress] = useState(espConnection.getState().ipAddress);

  useEffect(() => {
    // Subscribe to connection state changes
    const unsubscribe = espConnection.subscribe(state => {
      setConnected(state.connected);
      setLastCommand(state.lastCommand);
      setIpAddress(state.ipAddress);
    });

    // Clean up subscription when component unmounts
    return unsubscribe;
  }, []);

  // Define functions that wrap the service methods
  const connect = (ip?: string) => espConnection.connect(ip);
  const disconnect = () => espConnection.disconnect();
  const sendCommand = (command: Command) => espConnection.sendCommand(command);

  return {
    connected,
    lastCommand,
    ipAddress,
    connect,
    disconnect,
    sendCommand,
  };
}

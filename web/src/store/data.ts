import { writable } from 'svelte/store';
import type SheetData from '$types/data';

export default writable<SheetData>({
  footer: {
    serverId: 758,
    playerCount: 320,
    maxPlayers: 512,
  },
  groups: [
    { label: 'Police', count: 7, icon: 'ic:round-local-police' },
    { label: 'EMS', count: 6, icon: 'ic:round-local-hospital' },
    { label: 'Mechanics', count: 0, icon: 'mdi:wrench' },
    { label: 'Dealerships', count: 0, icon: 'mdi:car' },
  ],
  players: [
    { name: 'Bob', id: '758' },
    { name: 'George Washington had very long name', id: '32' },
    { name: 'Franta', id: '1' },
    { name: 'Zoo', id: '2000' },
    { name: 'John Doe', id: '1000' },
    { name: 'Jane Doe', id: '1001' },
    { name: 'John Doe', id: '1002' },
    { name: 'Jane Doe', id: '1003' },
    { name: 'John Doe', id: '1004' },
    { name: 'Jane Doe', id: '1005' },
    { name: 'John Doe', id: '1006' },
    { name: 'Jane Doe', id: '1007' },
    { name: 'John Doe', id: '1008' },
    { name: 'Jane Doe', id: '1009' },
  ],
  statusIndicators: [
    { label: 'House robbery', icon: 'mdi:house', state: true },
    { label: 'Store robbery', icon: 'mdi:store', state: true },
    { label: 'Bank robbery', icon: 'mdi:bank', state: false },
  ],
});

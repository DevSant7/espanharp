import { create } from "zustand";

type Data = {
  gems: number;
  vip?: {
    title: string;
    remaining: string;
  };
};

interface NuiFrame {
  current: Data;
  set: (current: Data) => void;
}

export const useBalance = create<NuiFrame>((set: any) => ({
  current: {
    gems: 0,
  },
  set: (current: Data) => set({ current }),
}));

import { create } from "zustand";
export type Character =
  | {
      type: "character";
      name: string;
      id: number;
      gender: string;
      age: number;
      bank: number;
      phone: string;
      gems: number;
      vip?: {
        title: string;
        remaining: number
      } | false
    }
  | {
      type: "slot";
    };

type Data = Character[];

interface NuiFrame {
  current: Data;
  set: (current: Data) => void;
}

export const useCharacters = create<NuiFrame>((set: any) => ({
  current: [],
  set: (current: Data) => set({ current }),
}));

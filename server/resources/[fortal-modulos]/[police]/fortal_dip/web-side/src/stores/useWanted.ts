import { IWantedUser, IWantedVehicle } from "@/types";

import { create } from "zustand";

interface WantedUserFrame {
  current: IWantedUser[];
  set: (current: IWantedUser[]) => void;
}

interface WantedVehicleFrame {
  current: IWantedVehicle[];
  set: (current: IWantedVehicle[]) => void;
}

export const useWantedVehicle = create<WantedVehicleFrame>((set) => ({
  current: [],
  set: (current: IWantedVehicle[]) => set({ current }),
}));

export const useWantedUser = create<WantedUserFrame>((set) => ({
  current: [],
  set: (current: IWantedUser[]) => set({ current }),
}));

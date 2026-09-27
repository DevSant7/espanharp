import { create } from "zustand";
import { Post } from "@/hooks/post";
import { usePrice } from "./usePrice";

export type Tattoos = Record<
  string,
  {
    id: number;
    collection: string;
    overlay: string;
    image: string;
    price: number;
    active?: boolean;
    camera?: string;
  }[]
>;

interface NuiFrame {
  current: Tattoos;
  set: (current: Tattoos) => void;
  setActive: (category: string, id: number, value: boolean) => void;
  getTotal: () => number;
  clear: () => void;
}

export const useTattoos = create<NuiFrame>((set, get) => ({
  current: {},
  set: (current: Tattoos) => set({ current }),

  setActive: (category, id, value) =>
    set((state) => {
      const updated = { ...state.current };

      if (!updated[category]) return {};

      updated[category] = updated[category].map((item) => {
        if (item.id == id) {
          Post.create<{price: number}>("Tattooshop:UpdateTattoos", { collection: item.collection, overlay: item.overlay, active: value }).then((response) => {
            if (response) usePrice.getState().set(response.price)
          })

          return {
            ...item,
            active: value
          }
        } else {
          return item
        }
      })

      return { current: updated };
    }),

  getTotal: () => {
    const current = get().current;
    let count = 0;

    for (const items of Object.values(current)) {
      for (const item of items) {
        if (item.active) {
          count++;
        }
      }
    }

    return count;
  },

  clear: () =>
    set((state) => {
      const cleared = Object.fromEntries(
        Object.entries(state.current).map(([category, items]) => [
          category,
          items.map((item) => ({ ...item, active: false })),
        ]),
      );

      return { current: cleared };
    }),
}));

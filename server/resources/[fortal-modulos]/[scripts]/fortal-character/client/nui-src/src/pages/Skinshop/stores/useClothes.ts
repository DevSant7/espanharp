import { create } from "zustand";
import { Post } from "@/hooks/post";
import { usePrice } from "./usePrice";

export type Clothes = Record<
  string,
  {
    id: number;
    image: string;
    active: boolean;
    camera?: string;
    texture: {
      selected: number;
      options: number;
    };
  }[]
>;

interface NuiFrame {
  current: Clothes;
  getTotal: () => number;
  set: (current: Clothes) => void;
  setActive: (category: string, id: number, value: boolean) => void;
  getActive: (category: string) => {
    item: {
      id: number;
      image: string;
      active: boolean;
      camera?: string;
      texture: {
        selected: number;
        options: number;
      };
    };
    index: number;
  } | null;

  incrementTexture: (category: string) => void;
  decrementTexture: (category: string) => void;
  getTextureData: (
    category: string,
  ) => { selected: number; options: number } | null;
}

export const useClothes = create<NuiFrame>((set, get) => ({
  current: {},
  set: (current: Clothes) => set({ current }),

  setActive: (category, id, value) =>
    set((state) => {
      const updated = { ...state.current };

      if (!updated[category]) return {};

      updated[category] = updated[category].map((item) => {
        if (item.id === id) {
          Post.create<{price: number}>("Skinshop:UpdateClothes", { section: category, item: id, texture: 0 }).then((response) => {
            if (response) usePrice.getState().set(response.price)
          })
        }

        return {
          ...item,
          texture: {
            ...item.texture,
            selected: 0
          },
          active: item.id === id ? value : false
        }
      })

      return { current: updated };
    }),

  getActive: (category) => {
    const current = get().current[category];
    if (!current) return null;

    const index = current.findIndex((item) => item.active);
    if (index === -1) return null;

    return {
      item: current[index],
      index,
    };
  },

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

  incrementTexture: (category) =>
    set((state) => {
      const updated = { ...state.current };
      const items = updated[category];

      if (!items) return {};

      updated[category] = items.map((item) => {
        if (!item.active) return item;

        const current = item.texture.selected;
        const max = item.texture.options;

        Post.create<{price: number}>("Skinshop:UpdateClothes", { section: category, item: item.id, texture: (current + 1) % (max + 1) }).then((response) => {
          if (response) usePrice.getState().set(response.price)
        })

        return {
          ...item,
          texture: {
            ...item.texture,
            selected: (current + 1) % (max + 1),
          },
        };
      });

      return { current: updated };
    }),

  decrementTexture: (category) =>
    set((state) => {
      const updated = { ...state.current };
      const items = updated[category];

      if (!items) return {};

      updated[category] = items.map((item) => {
        if (!item.active) return item;

        const current = item.texture.selected;
        const max = item.texture.options;

        Post.create<{price: number}>("Skinshop:UpdateClothes", { section: category, item: item.id, texture: (current - 1 + max) % max }).then((response) => {
          if (response) usePrice.getState().set(response.price)
        })

        return {
          ...item,
          texture: {
            ...item.texture,
            selected: (current - 1 + max) % max,
          },
        };
      });

      return { current: updated };
    }),

  getTextureData: (category) => {
    const current = get().current[category];
    if (!current) return null;

    const activeItem = current.find((item) => item.active);
    if (!activeItem) return null;

    return activeItem.texture;
  },
}));

import { Slider, SliderThumb, SliderTrack } from "@radix-ui/react-slider";

import { GeneralIcons } from "@/components/Icons";
import { usePartial } from "../stores/usePartial";
import { useCamera } from "../stores/useCamera";
import { Post } from "@/hooks/post";
import { usePrice } from "../stores/usePrice";

export default function Field({
  descriminator,
  data,
}: {
  descriminator: string;
  data: any;
}) {
  const { set: setCamera } = useCamera();
  const partial = usePartial();
  const price = usePrice();

  const handleUpdate = (value: any) => {
    Post.create<{price: number}>("Barbershop:UpdateAppearance", { id: descriminator, value }).then((response) => {
      if (response) price.set(response.price)
    })
    Post.create<{camera: string}>("Character:SetCamera", { section: "Barbershop", id: data.camera }).then((response) => {
      if (response) setCamera(data.camera)
    })
  }

  return (
    <li className="flex w-full flex-none flex-col gap-2.5">
      <p className="w-full text-base font-medium text-center text-white/85">
        {data.title}
      </p>
      <div className="flex h-[2.8125rem] gap-[0.31rem]">
        <button
          onClick={() => {
            const newValue = Math.max(data.value - 1, data.min);

            partial.decrement(descriminator);
            handleUpdate(newValue);
          }}
          className="bg-section grid size-[2.8125rem] flex-none place-items-center rounded-md border border-white/15 hover:bg-white/10 active:scale-95 transition-all duration-200"
        >
          <GeneralIcons.ChevronLeft className="h-4" />
        </button>
        <div className="bg-section grid h-full w-16 flex-none place-items-center rounded-md border border-white/15 text-center text-[1.1875rem] leading-none text-white/90">
          {data.value}
        </div>
        <div className="bg-section flex size-full items-center rounded-md border border-white/15 px-3.5">
          <Slider
            className="relative flex h-[0.8125rem] w-full items-center overflow-visible transition-none duration-0"
            value={[data.value]}
            onValueChange={([v]) => {
              partial.update(descriminator, v);
              handleUpdate(v);
            }}
            max={data.max}
            min={data.min}
            step={1}
          >
            <SliderTrack className="relative h-[0.3125rem] flex-grow rounded-full bg-white/15 transition-none duration-0" />
            <SliderThumb className="glow block size-[0.8125rem] rounded-full bg-primary transition-none duration-0" />
          </Slider>
        </div>
        <button
          onClick={() => {
            const newValue = Math.min(data.value + 1, data.max);

            partial.increment(descriminator)
            handleUpdate(newValue);
          }}
          className="bg-section grid size-[2.8125rem] flex-none place-items-center rounded-md border border-white/15 hover:bg-white/10 active:scale-95 transition-all duration-200"
        >
          <GeneralIcons.ChevronRight className="h-4" />
        </button>
      </div>
    </li>
  );
}

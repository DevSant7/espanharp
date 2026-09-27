import { FixedSizeGrid as Grid } from 'react-window';
import { cn } from "@/utils/misc";
import { Post } from "@/hooks/post";
import { useHair } from "../stores/useHair";
import { useCamera } from "../stores/useCamera";
import { usePrice } from "../stores/usePrice";

export default function Hairstyles() {
  const { set: setCamera } = useCamera();
  const { set: setPrice }  = usePrice();
  const hair = useHair();
  const active = (i: number) => i + 1 === hair.current.selected;
  return (
    <div className="scroll-hidden h-[17.25rem] w-full flex-none overflow-y-scroll">
      <Grid
        columnCount={4}
        columnWidth={104}
        height={300}
        rowCount={Math.ceil(hair.current.options.length / 4)}
        rowHeight={105}
        width={560}
      >
        {({ columnIndex, rowIndex, style }: { columnIndex: number; rowIndex: number; style: any }) => {
          const index = rowIndex * 4 + columnIndex;
          const data = hair.current.options[index]

          if (data) return (      
            <div
              key={index}
              style={{
                ...style,
                display: "flex",
                justifyContent: "center",
                alignItems: "flex-start",
                boxSizing: "border-box", 
              }}
            >
              <button
                key={index}
                onClick={() => {
                  hair.setSelected(index + 1);            
                  Post.create<{price: number}>("Barbershop:UpdateAppearance", { id: "hair", value: index }).then((response) => {
                    if (response) setPrice(response.price)
                  })            
                  Post.create<boolean>("Character:SetCamera", { section: "Barbershop", id: "hair" }).then((response) => {
                    if (response) setCamera("hair")
                  })            
                  if (index + 1 !== hair.current.selected) hair.setEdited(true);
                }}
                disabled={active(index)}
                className={cn(
                  "bg-section relative size-[6.25rem] flex-none rounded-md border",
                  active(index) ? "border-primary" : "border-white/15",
                )}
              >
                <img
                  className="object-cover object-center size-full"
                  src={data}
                  draggable={false}
                  onError={(e) => {
                    e.currentTarget.style.display = "none";
                  }}
                />
                <div
                  className={cn(
                    "absolute left-1.5 top-1.5 grid size-[1.4375rem] place-items-center rounded text-[0.8125rem] font-medium leading-none text-white/90",
                    active(index) ? "bg-gradient-primary" : "bg-black/55",
                  )}
                >
                  {index + 1}
                </div>
              </button>
            </div>
          )
        }}
      </Grid>
    </div>
  );
}

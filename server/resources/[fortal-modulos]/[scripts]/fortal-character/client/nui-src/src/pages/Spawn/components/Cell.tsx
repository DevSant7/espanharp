import { useEffect, useRef } from "react";
import { gsap } from "gsap";
import { Post } from "@/hooks/post";
import { type Location } from "../stores/useLocations";
import { cn } from "@/utils/misc";

export function Cell({ data, index = 0 }: { data: Location, index: number }) {
    const spawnRef = useRef<HTMLDivElement>(null);

    useEffect(() => {
      if (spawnRef.current) {
        gsap.set(spawnRef.current, {
          opacity: 0,
          scale: 0.95,
          y: 20,
        });

        gsap.to(spawnRef.current, {
          opacity: 1,
          scale: 1,
          y: 0,
          duration: 0.25,
          ease: "power3.out",
          delay: index * 0.5,
        });
      }
    }, [index]);

    return (
        <div
            ref={spawnRef}
            onClick={() => Post.create("Spawn:Location", data)}
            className={cn(
                "flex flex-col flex-shrink-0 items-center justify-end", 
                "relative w-[24.3125rem] h-[36.75rem] opacity-0", 
                "cursor-pointer rounded-lg pb-8 group transition-all duration-300"
            )}
        >
            <img
                src={data.image}
                alt="Location Img"
                className="absolute top-0 left-0 w-full h-full z-[1] rounded-lg"
            />

            <div className={cn(
                "absolute inset-0 z-[3] w-full h-full",  
                "bg-gradient-to-b from-transparent to-[#070916]/50",
            )}></div>

            <div className={cn(
                "absolute inset-0 z-[10]",  
                "bg-gradient-to-b from-transparent to-[#070916]/20",
                "rounded-lg group-hover:opacity-0 transition-opacity duration-300",
                "border-[1px] border-solid border-white/10"
            )}></div>

            <div className={cn(
                "absolute inset-0 z-[10]", 
                "border-primary border-solid border rounded-lg", 
                "opacity-0 group-hover:opacity-100 transition-opacity duration-300"
            )}></div>

            <div className={cn(
                "flex flex-shrink-0 justify-center items-center", 
                "h-11 p-2.5 gap-2.5 z-[3]", 
                "border-[1px] border-solid border-white/10 rounded-md", 
                "bg-[radial-gradient(95.47%_60.03%_at_49.84%_76.67%,_rgba(255,_255,_255,_0.06)_0%,_rgba(255,_255,_255,_0.00)_100%),_linear-gradient(91deg,_rgba(255,_255,_255,_0.01)_0%,_rgba(255,_255,_255,_0.01)_100%)]", 
                "group-hover:bg-primary transition-all duration-300"
            )}>
                <h1 className="text-[#FFF] text-center text-lg font-bold">
                {data.name}
                </h1>
            </div>
        </div>
    );
}

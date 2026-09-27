export function Background({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex h-screen w-screen items-center bg-gradient-to-r from-[#070916] from-[-30%] to-transparent to-[64%]">
      <div className="flex h-screen w-screen items-center bg-gradient-to-l from-[#070916] from-[-30%] to-transparent to-[64%]">
        {children}
      </div>
    </div>
  );
}

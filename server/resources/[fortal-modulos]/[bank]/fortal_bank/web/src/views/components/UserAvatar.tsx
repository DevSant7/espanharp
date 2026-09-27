import { User } from "lucide-react";
import { useAccountInfo } from "../../hooks/useAccountInfo";

interface UserAvatarProps {
  size?: "sm" | "md" | "lg";
  className?: string;
}

export function UserAvatar({ size = "md", className = "" }: UserAvatarProps) {
  const { accountInfo, loading } = useAccountInfo();

  const sizeClasses = {
    sm: "w-8 h-8",
    md: "w-10 h-10", 
    lg: "w-16 h-16"
  };

  const iconSizes = {
    sm: "w-4 h-4",
    md: "w-5 h-5",
    lg: "w-8 h-8"
  };

  if (loading) {
    return (
      <div className={`${sizeClasses[size]} rounded-full bg-white/10 animate-pulse ${className}`}>
      </div>
    );
  }

  return (
    <div className={`${sizeClasses[size]} rounded-full overflow-hidden ${className}`}>
      {accountInfo?.profile_photo ? (
        <img
          src={accountInfo.profile_photo}
          alt="Profile"
          className="w-full h-full object-cover"
        />
      ) : (
        <div className="w-full h-full bg-[#df5454] flex items-center justify-center">
          <User className={`${iconSizes[size]} text-white`} />
        </div>
      )}
    </div>
  );
}

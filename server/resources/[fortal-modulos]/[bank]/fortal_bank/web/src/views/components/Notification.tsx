import { useState, useEffect } from "react";

interface NotificationData {
  type: "success" | "error" | "info";
  message: string;
  id: number;
}

export function Notification() {
  const [notifications, setNotifications] = useState<NotificationData[]>([]);
  const [nextId, setNextId] = useState(1);

  useEffect(() => {
    const handleMessage = (event: MessageEvent) => {
      const { action, data } = event.data;
      
      if (action === "showNotification") {
        const newNotification: NotificationData = {
          type: data.type,
          message: data.message,
          id: nextId
        };
        
        setNotifications(prev => [...prev, newNotification]);
        setNextId(prev => prev + 1);
        
        // Remove notification after 5 seconds
        setTimeout(() => {
          setNotifications(prev => prev.filter(notif => notif.id !== newNotification.id));
        }, 5000);
      }
    };

    window.addEventListener("message", handleMessage);
    
    return () => {
      window.removeEventListener("message", handleMessage);
    };
  }, [nextId]);

  const getNotificationStyle = (type: string) => {
    switch (type) {
      case "success":
        return "bg-green-600 border-green-500";
      case "error":
        return "bg-red-600 border-red-500";
      case "info":
        return "bg-blue-600 border-blue-500";
      default:
        return "bg-gray-600 border-gray-500";
    }
  };

  return (
    <div className="fixed top-4 right-4 z-50 space-y-2">
      {notifications.map((notification) => (
        <div
          key={notification.id}
          className={`max-w-sm w-full border rounded-lg p-4 shadow-lg transition-all duration-300 ease-in-out transform translate-x-0 opacity-100 animate-slide-in ${getNotificationStyle(notification.type)}`}
        >
          <div className="flex items-center">
            <div className="flex-shrink-0">
              {notification.type === "success" && (
                <svg className="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                  <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
                </svg>
              )}
              {notification.type === "error" && (
                <svg className="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                  <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clipRule="evenodd" />
                </svg>
              )}
              {notification.type === "info" && (
                <svg className="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                  <path fillRule="evenodd" d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-7-4a1 1 0 11-2 0 1 1 0 012 0zM9 9a1 1 0 000 2v3a1 1 0 001 1h1a1 1 0 100-2v-3a1 1 0 00-1-1H9z" clipRule="evenodd" />
                </svg>
              )}
            </div>
            <div className="ml-3">
              <p className="text-sm font-medium text-white">
                {notification.message}
              </p>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}

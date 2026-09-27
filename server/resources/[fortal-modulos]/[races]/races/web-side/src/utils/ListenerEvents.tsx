import { useEffect } from 'react';

interface ListenerEvents {
  message: (data: any) => any;
}

const useMessageListener = (messageHandler: ListenerEvents['message']): void => {

  useEffect(() => {
    const handleMessage = (event: MessageEvent): void => messageHandler(event.data);

    window.addEventListener('message', handleMessage);

    return () => window.removeEventListener('message', handleMessage);
  }, [messageHandler]);
};


export default useMessageListener
import { FinishRaceComponent } from "./components/finishRace";
import { HoverEnter } from "./components/HoverEnter";
import { HoverWait } from "./components/HoverWait";
import { InRaceComponent } from "./components/inRace";
import { StartRace } from "./components/StartRace";
import useMessageListener from "./utils/ListenerEvents";
import { useState } from "react";

const App = () => {
  const [messageData, setMessageData] = useState<any>(null);

  const handleMessage = (data: any) => {
    if (data.display === false && data.action === messageData?.action) {
      setMessageData(null);
    } else {
      setMessageData(data);
    }
  };
  useMessageListener(handleMessage);

  const renderContent = () => {
    if (!messageData) {
      return null;
    }
    
    switch (messageData.action) {
      case "inRace":
        return <InRaceComponent messageData={messageData} />;
      case "FinishRace":
        return <FinishRaceComponent messageData={messageData} />;
      case "HoverEnter":
        return <HoverEnter />;
      case "HoverWait":
        return <HoverWait messageData={messageData} />;
      case "StartRace":
        return <StartRace messageData={messageData} />;
      default:
        return null;
    }
  };

  return <div className="main">{renderContent()}</div>;
};
export default App;

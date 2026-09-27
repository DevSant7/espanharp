import "@/style/global.css";
import ReactDOM from "react-dom/client";
import { HashRouter } from "react-router-dom";
import { Interface } from "@/components/Interface";
import { VisibilityProvider } from "@/providers/Visibility";
import { PermissionsProvider } from "@/providers/Permissions";

declare global {
  interface Window {
    invokeNative?: any;
  }
}

const rootElement = document.getElementById("root");

if (rootElement) {
  try {
    const App = () => {
      return (
        <div style={{
          position: 'fixed',
          top: 0,
          left: 0,
          width: '100%',
          height: '100%',
          zIndex: 9999
        }}>
          <HashRouter>
            <PermissionsProvider>
              <VisibilityProvider>
                <Interface />
              </VisibilityProvider>
            </PermissionsProvider>
          </HashRouter>
        </div>
      );
    };

    ReactDOM.createRoot(rootElement).render(<App />);
  } catch (error) {
    console.error('[NUI] Erro ao renderizar React:', error);
  }
} else {
  console.error('[NUI] Root element não encontrado!');
}

import React, { useState } from 'react';
import { Home, User, Layers, Hexagon, ArrowUp, Eye, ScanLine } from 'lucide-react';

export default function App() {
  const [activeTab, setActiveTab] = useState('Data');
  const [isFabMenuOpen, setIsFabMenuOpen] = useState(false);

  const tabs = [
    { id: 'Home', icon: Home },
    { id: 'User', icon: User },
    { id: 'Data', icon: Layers },
  ];

  return (
    <div className="min-h-screen w-full bg-gray-100 flex items-center justify-center p-4 sm:p-8 font-sans">
      {/* Mobile Simulator Frame */}
      <div className="relative w-full max-w-[390px] h-[844px] bg-[#d7d7d9] rounded-[3rem] shadow-2xl overflow-hidden border-[6px] border-[#2a2a2c]">
        
        {/* Mock App Content/Background */}
        <div className="absolute inset-0 flex flex-col items-center justify-center opacity-40">
          <Layers size={64} className="text-gray-400 mb-4" />
          <p className="text-gray-500 font-medium">App Content Area</p>
        </div>

        {/* STATE 2: EXPANDED FAB MENU (Image 3) 
          Shows when the right hexagon button is clicked
        */}
        <div 
          className={`absolute inset-0 bg-[#0c0c0e] z-40 transition-opacity duration-500 ${
            isFabMenuOpen ? 'opacity-100 pointer-events-auto' : 'opacity-0 pointer-events-none'
          }`}
        >
          {/* Close overlay area */}
          <div className="absolute inset-0" onClick={() => setIsFabMenuOpen(false)} />

          {/* Expanded Menu Container */}
          <div className="absolute bottom-10 right-6 w-[300px] h-[280px] pointer-events-none">
            
            {/* High-tech SVG Connecting Lines matching Image 3 */}
            <svg 
              className="absolute inset-0 w-full h-full text-[#333333]" 
              viewBox="0 0 300 280" 
              fill="none" 
              stroke="currentColor" 
              strokeWidth="2"
            >
              {/* Line from Access (bottom right) to Eye (bottom left) */}
              <path d="M 270 230 L 180 230 Q 170 230 170 220 L 170 175 Q 170 165 160 165 L 35 165" />
              {/* Line branching up to Red (top left) */}
              <path d="M 170 200 L 170 45 Q 170 35 160 35 L 135 35" />
              {/* Line branching from Red to Scan (top right) */}
              <path d="M 170 35 L 235 35 Q 245 35 245 45 L 245 75" />
            </svg>

            {/* Buttons (pointer-events-auto to make them clickable over the SVG) */}
            <div className="absolute inset-0 pointer-events-auto">
              {/* Anchor Button: Access */}
              <div className="absolute bottom-0 right-0 flex flex-col items-center gap-2 translate-x-3 translate-y-4 cursor-pointer" onClick={() => setIsFabMenuOpen(false)}>
                <div className="w-[60px] h-[60px] flex items-center justify-center text-[#8e8e93]">
                  <Hexagon size={28} strokeWidth={1.5} />
                </div>
                <span className="text-[#8e8e93] text-sm font-medium -mt-2 tracking-wide">Access</span>
              </div>

              {/* Action Button: Eye (Cyan) */}
              <button className="absolute bottom-[45px] left-0 w-[70px] h-[70px] rounded-full border border-[#2a2a2c] bg-[#0c0c0e] flex items-center justify-center shadow-[0_0_25px_rgba(0,0,0,0.8)] -translate-x-1/2 translate-y-1/2 hover:bg-[#1a1a1c] transition-colors">
                <Eye size={24} className="text-[#3b9f9f]" strokeWidth={1.5} />
              </button>

              {/* Action Button: Record/Red Dot */}
              <button className="absolute top-[35px] left-[135px] w-[70px] h-[70px] rounded-full border border-[#2a2a2c] bg-[#0c0c0e] flex items-center justify-center shadow-[0_0_25px_rgba(0,0,0,0.8)] -translate-x-1/2 -translate-y-1/2 hover:bg-[#1a1a1c] transition-colors">
                <div className="w-[18px] h-[18px] rounded-full bg-[#d63f3f] shadow-[0_0_12px_rgba(214,63,63,0.6)]" />
              </button>

              {/* Action Button: Scan (Blue) */}
              <button className="absolute top-[75px] right-[25px] w-[70px] h-[70px] rounded-full border border-[#2a2a2c] bg-[#0c0c0e] flex items-center justify-center shadow-[0_0_25px_rgba(0,0,0,0.8)] translate-x-1/2 -translate-y-1/2 hover:bg-[#1a1a1c] transition-colors">
                <ScanLine size={24} className="text-[#4b89a8]" strokeWidth={1.5} />
              </button>
            </div>
          </div>
        </div>

        {/* STATE 1: DEFAULT NAVIGATION BAR (Images 1 & 2) 
          Floats at the bottom of the screen
        */}
        <div 
          className={`absolute bottom-8 left-1/2 -translate-x-1/2 flex items-center gap-3 bg-[#e0e0e0]/80 backdrop-blur-md p-2 rounded-full shadow-[0_12px_40px_rgba(0,0,0,0.12)] transition-transform duration-500 ${
            isFabMenuOpen ? 'translate-y-32 opacity-0' : 'translate-y-0 opacity-100'
          }`}
        >
          {/* Main Navigation Pill */}
          <div className="flex bg-[#1d1d1f] p-1.5 rounded-full items-center relative">
            
            {/* Tooltip for 'Data' Tab (Image 2) */}
            {activeTab === 'Data' && (
              <div className="absolute -top-[52px] right-2 bg-[#1d1d1f] px-3 py-1.5 rounded-full flex items-center gap-2 shadow-xl animate-float pointer-events-none">
                <span className="text-[#a1a1a6] text-xs font-semibold tracking-wider">+6%</span>
                <div className="w-[18px] h-[18px] rounded-full bg-[#5ec28e] flex items-center justify-center">
                  <ArrowUp size={12} strokeWidth={4} className="text-[#1d1d1f]" />
                </div>
                {/* Tooltip Arrow pointing down */}
                <div className="absolute -bottom-1 left-1/2 -translate-x-1/2 w-3 h-3 bg-[#1d1d1f] rotate-45 rounded-[2px]" />
              </div>
            )}

            {/* Render Tabs */}
            {tabs.map((tab) => {
              const Icon = tab.icon;
              const isActive = activeTab === tab.id;

              return (
                <button
                  key={tab.id}
                  onClick={() => setActiveTab(tab.id)}
                  className={`relative flex items-center justify-center rounded-full transition-all duration-400 ease-out h-[48px] ${
                    isActive 
                      ? 'bg-[#e5e5ea] text-[#1d1d1f] px-5 w-auto' 
                      : 'bg-transparent text-[#8e8e93] w-[48px] hover:text-[#b0b0b5]'
                  }`}
                >
                  <Icon size={20} strokeWidth={isActive ? 2 : 1.5} className="shrink-0 z-10" />
                  
                  {/* Text Container: Expands when active, shrinks when inactive */}
                  <div
                    className={`overflow-hidden transition-all duration-400 ease-out flex items-center ${
                      isActive ? 'max-w-[100px] opacity-100 ml-2.5' : 'max-w-0 opacity-0 ml-0'
                    }`}
                  >
                    <span className="font-semibold text-[15px] z-10">{tab.id}</span>
                  </div>
                </button>
              );
            })}
          </div>

          {/* Right Floating Action Button (FAB) */}
          <button 
            onClick={() => setIsFabMenuOpen(true)}
            className="w-[60px] h-[60px] bg-[#1d1d1f] rounded-full flex items-center justify-center text-[#a1a1a6] hover:bg-[#2c2c2e] transition-colors shadow-inner"
          >
            <Hexagon size={24} strokeWidth={1.5} />
          </button>
        </div>

      </div>

      {/* Custom Keyframes for the floating tooltip */}
      <style dangerouslySetInnerHTML={{__html: `
        @keyframes float {
          0%, 100% { transform: translateY(0px); }
          50% { transform: translateY(-4px); }
        }
        .animate-float {
          animation: float 3s ease-in-out infinite;
        }
      `}} />
    </div>
  );
}


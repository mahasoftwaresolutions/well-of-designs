import React, { useState } from 'react';
import { Home, User, Layers, Hexagon, ArrowUp, Eye, ScanLine } from 'lucide-react';

export default function App() {
  const [activeTab, setActiveTab] = useState('Data');
  const [isFabMenuOpen, setIsFabMenuOpen] = useState(false);
  const [lastAction, setLastAction] = useState('None'); // Added state to show clickability

  const tabs = [
    { id: 'Home', icon: Home },
    { id: 'User', icon: User },
    { id: 'Data', icon: Layers },
  ];

  // Handle clicking the vertical FAB actions
  const handleFabClick = (actionName) => {
    setLastAction(actionName);
    setIsFabMenuOpen(false); // Close menu on click
  };

  // Calculate the horizontal offset for the sliding background pill
  const getIndicatorOffset = () => {
    switch(activeTab) {
      case 'Home': return 0;
      case 'User': return 48; // Width of one inactive tab
      case 'Data': return 96; // Width of two inactive tabs
      default: return 0;
    }
  };

  return (
    <div className="min-h-screen w-full bg-gray-100 flex items-center justify-center p-4 sm:p-8 font-sans">
      {/* Mobile Simulator Frame */}
      <div className="relative w-full max-w-[390px] h-[844px] bg-[#d7d7d9] rounded-[3rem] shadow-2xl overflow-hidden border-[6px] border-[#2a2a2c]">
        
        {/* Mock App Content/Background */}
        <div className="absolute inset-0 flex flex-col items-center justify-center opacity-40">
          <Layers size={64} className="text-gray-400 mb-4" />
          <p className="text-gray-500 font-medium">App Content Area</p>
          <p className="text-gray-400 text-sm mt-2 font-semibold tracking-wide">Last Action: {lastAction}</p>
        </div>

        {/* Overlay for FAB menu */}
        <div 
          className={`absolute inset-0 bg-[#0c0c0e]/40 backdrop-blur-[2px] z-30 transition-opacity duration-300 ${
            isFabMenuOpen ? 'opacity-100 pointer-events-auto' : 'opacity-0 pointer-events-none'
          }`}
          onClick={() => setIsFabMenuOpen(false)}
        />

        {/* Navigation & FAB Container */}
        <div className="absolute bottom-8 left-1/2 -translate-x-1/2 flex items-center gap-3 z-40">
          
          {/* Main Navigation Pill */}
          <div className="relative flex bg-[#1d1d1f] p-1.5 rounded-full items-center shadow-[0_12px_40px_rgba(0,0,0,0.2)]">
            
            {/* Sliding Background Indicator */}
            <div 
              className="absolute top-1.5 bottom-1.5 left-1.5 bg-[#e5e5ea] rounded-full transition-transform duration-300 ease-out"
              style={{
                width: '110px',
                transform: `translateX(${getIndicatorOffset()}px)`
              }}
            />

            {/* Tooltip for 'Data' Tab */}
            {activeTab === 'Data' && (
              <div className="absolute -top-[52px] right-2 bg-[#1d1d1f] px-3 py-1.5 rounded-full flex items-center gap-2 shadow-xl animate-float pointer-events-none z-20">
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
                  className={`relative z-10 flex items-center justify-center rounded-full transition-all duration-300 ease-out h-[48px] ${
                    isActive 
                      ? 'w-[110px] text-[#1d1d1f]' 
                      : 'w-[48px] text-[#8e8e93] hover:text-[#b0b0b5]'
                  }`}
                >
                  <Icon size={20} strokeWidth={isActive ? 2 : 1.5} className="shrink-0" />
                  
                  {/* Text Container */}
                  <div
                    className={`overflow-hidden transition-all duration-300 ease-out flex items-center ${
                      isActive ? 'max-w-[100px] opacity-100 ml-2.5' : 'max-w-0 opacity-0 ml-0'
                    }`}
                  >
                    <span className="font-semibold text-[15px]">{tab.id}</span>
                  </div>
                </button>
              );
            })}
          </div>

          {/* Right Floating Action Button (FAB) Area */}
          <div className="relative">
            
            {/* Vertical Stacked Buttons */}
            <div 
              className={`absolute bottom-full mb-4 left-1/2 -translate-x-1/2 flex flex-col gap-3 transition-all duration-300 origin-bottom ${
                isFabMenuOpen 
                  ? 'opacity-100 translate-y-0 scale-100 pointer-events-auto' 
                  : 'opacity-0 translate-y-8 scale-90 pointer-events-none'
              }`}
            >
              <button 
                onClick={() => handleFabClick('Scan')}
                className="w-[52px] h-[52px] rounded-full border border-[#2a2a2c] bg-[#1d1d1f] flex items-center justify-center shadow-lg hover:bg-[#2c2c2e] transition-colors group"
                title="Scan"
              >
                <ScanLine size={20} className="text-[#4b89a8] group-hover:scale-110 transition-transform" strokeWidth={1.5} />
              </button>
              
              <button 
                onClick={() => handleFabClick('Record')}
                className="w-[52px] h-[52px] rounded-full border border-[#2a2a2c] bg-[#1d1d1f] flex items-center justify-center shadow-lg hover:bg-[#2c2c2e] transition-colors group"
                title="Record"
              >
                <div className="w-[14px] h-[14px] rounded-full bg-[#d63f3f] shadow-[0_0_8px_rgba(214,63,63,0.6)] group-hover:scale-110 transition-transform" />
              </button>
              
              <button 
                onClick={() => handleFabClick('View')}
                className="w-[52px] h-[52px] rounded-full border border-[#2a2a2c] bg-[#1d1d1f] flex items-center justify-center shadow-lg hover:bg-[#2c2c2e] transition-colors group"
                title="View"
              >
                <Eye size={20} className="text-[#3b9f9f] group-hover:scale-110 transition-transform" strokeWidth={1.5} />
              </button>
            </div>

            {/* Anchor FAB */}
            <button 
              onClick={() => setIsFabMenuOpen(!isFabMenuOpen)}
              className={`w-[60px] h-[60px] bg-[#1d1d1f] rounded-full flex items-center justify-center text-[#a1a1a6] transition-all duration-300 shadow-inner ${
                isFabMenuOpen ? 'rotate-90 bg-[#2c2c2e] text-white' : 'rotate-0 hover:bg-[#2c2c2e]'
              }`}
            >
              <Hexagon size={24} strokeWidth={1.5} />
            </button>
          </div>
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



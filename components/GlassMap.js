import { useEffect, useRef, useState } from 'react';

const GlassMap = ({ apiKey, address }) => {
  const mapRef = useRef(null);
  const [mapLoaded, setMapLoaded] = useState(false);
  const defaultLocation = { lat: 40.7128, lng: -74.0060 }; // Default to New York City

  useEffect(() => {
    // Check if the script is already loaded
    if (window.google) {
      initMap();
      return;
    }

    // Load the Google Maps script
    const script = document.createElement('script');
    script.src = `https://maps.googleapis.com/maps/api/js?key=${apiKey}`;
    script.async = true;
    script.onload = () => {
      setMapLoaded(true);
      initMap();
    };
    document.head.appendChild(script);

    return () => {
      // Cleanup script if component unmounts before loading
      if (!window.google) {
        document.head.removeChild(script);
      }
    };
  }, [apiKey, address]);

  const initMap = () => {
    if (!window.google || !mapRef.current) return;

    // Create map instance with custom styling
    const map = new window.google.maps.Map(mapRef.current, {
      zoom: 15,
      center: defaultLocation,
      disableDefaultUI: true,
      styles: [
        {
          "featureType": "all",
          "elementType": "labels.text.fill",
          "stylers": [{"color": "#6c7079"}]
        },
        {
          "featureType": "landscape",
          "elementType": "all",
          "stylers": [{"color": "#f2f2f2"}]
        },
        {
          "featureType": "poi",
          "elementType": "all",
          "stylers": [{"visibility": "off"}]
        },
        {
          "featureType": "road",
          "elementType": "all",
          "stylers": [{"saturation": -100}, {"lightness": 45}]
        },
        {
          "featureType": "transit",
          "elementType": "all",
          "stylers": [{"visibility": "simplified"}]
        },
        {
          "featureType": "water",
          "elementType": "all",
          "stylers": [{"color": "#c4e5f9"}, {"visibility": "on"}]
        }
      ]
    });

    // Geocode address to get coordinates
    const geocoder = new window.google.maps.Geocoder();
    if (address) {
      geocoder.geocode({ address }, (results, status) => {
        if (status === 'OK' && results[0]) {
          const location = results[0].geometry.location;
          map.setCenter(location);

          // Add marker with animation
          new window.google.maps.Marker({
            map,
            position: location,
            animation: window.google.maps.Animation.DROP,
            icon: {
              path: window.google.maps.SymbolPath.CIRCLE,
              scale: 10,
              fillColor: '#3B82F6',
              fillOpacity: 1,
              strokeColor: '#ffffff',
              strokeWeight: 2,
            }
          });
        }
      });
    }
  };

  return (
    <div className="relative w-full h-[400px] rounded-2xl overflow-hidden">
      {/* Map container */}
      <div 
        ref={mapRef} 
        className="w-full h-full rounded-2xl"
      />
      
      {/* Glass overlay - only show while loading */}
      {!mapLoaded && (
        <div className="absolute inset-0 flex items-center justify-center bg-white/30 dark:bg-black/30 backdrop-blur-sm">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-500"></div>
        </div>
      )}
    </div>
  );
};

export default GlassMap; 
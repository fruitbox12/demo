import { useEffect, useState } from 'react';

export default function Home() {
  const [data, setData] = useState(null);

  useEffect(() => {
    fetch('/api/getData')
      .then(response => response.json())
      .then(data => setData(data));
  }, []);

  return (
    <div>
      {data && (
        <form>
          {Object.entries(data).map(([key, value]) => {
            if (key === 'base64Image') {
              return <img key={key} src={`data:image/png;base64,${value}`} alt='Base64 Image' />;
            }
            return <input key={key} type='text' name={key} value={value} readOnly />;
          })}
        </form>
      )}
    </div>
  );
}

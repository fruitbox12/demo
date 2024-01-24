#!/bin/bash

# Create Next.js app

# Create API routes
echo "let receivedData = null;

export default function handler(req, res) {
  if (req.method === 'POST') {
    receivedData = req.body;
    res.status(200).json({ message: 'Data received' });
  } else {
    res.setHeader('Allow', ['POST']);
    res.status(405).end(\`Method \${req.method} Not Allowed\`);
  }
}" > pages/api/data.js

echo "export default function handler(req, res) {
  if (req.method === 'GET') {
    res.status(200).json(receivedData);
  } else {
    res.setHeader('Allow', ['GET']);
    res.status(405).end(\`Method \${req.method} Not Allowed\`);
  }
}" > pages/api/getData.js

# Create frontend page
echo "import { useEffect, useState } from 'react';

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
              return <img key={key} src={\`data:image/png;base64,\${value}\`} alt='Base64 Image' />;
            }
            return <input key={key} type='text' name={key} value={value} readOnly />;
          })}
        </form>
      )}
    </div>
  );
}" > pages/index.js

# Install dependencies and run the app
npm install
npm run dev

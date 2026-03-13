/** @type {import('next').NextConfig} */
const nextConfig = {
  eslint: {
    ignoreDuringBuilds: true, // Skip ESLint during build
  },
  typescript: {
    ignoreBuildErrors: true, // Skip TypeScript errors
  },
  images: {
    unoptimized: true, // Useful for deployment without image optimization
  },
  env: {
    NEXT_PUBLIC_API_URL: process.env.NEXT_PUBLIC_API_URL || 'http://localhost:5000',
  },
  webpack(config) {
    config.optimization.splitChunks = {
      chunks: "all",
      maxSize: 25 * 1024 * 1024, // 25 MB
    };
    return config;
  },
  // Remove static export for server-side deployment
  // output: "export", // Commented out for Coolify deployment
  // Optional: set metadataBase if you use Open Graph/Twitter cards
  // metadataBase: new URL("https://yourdomain.com"),
};

module.exports = nextConfig;

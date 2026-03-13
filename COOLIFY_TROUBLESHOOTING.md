# Coolify Deployment Troubleshooting Guide

## 🚨 Common Deployment Issues and Solutions

### Issue 1: "spawn pnpm ENOENT" Error

**Problem**: Next.js tries to install TypeScript dependencies using pnpm which isn't available in the container.

**Solution**: ✅ **Already Fixed**
- Updated Dockerfile to use Node.js 20
- Added `NEXT_TELEMETRY_DISABLED=1` environment variable
- Removed static export configuration
- Updated package.json engines to require Node.js 20+

### Issue 2: Node.js Version Mismatch

**Problem**: Frontend requires Node.js 20+ but Dockerfile uses Node.js 18.

**Solution**: ✅ **Already Fixed**
- Updated both frontend and backend stages to use `node:20-alpine`
- Updated package.json engines to `"node": ">=20 <=22"`

### Issue 3: Build Failures Due to Missing Dependencies

**Problem**: Frontend build fails because TypeScript dependencies aren't installed.

**Solution**: ✅ **Already Fixed**
- Changed `npm ci --only=production` to `npm ci` in frontend stage
- This installs devDependencies needed for TypeScript compilation

## 🔧 Additional Troubleshooting Steps

### If Build Still Fails:

1. **Check Frontend Configuration**
   ```bash
   # Verify Next.js config
   cat frontend/next.config.js
   
   # Ensure no static export
   grep "output.*export" frontend/next.config.js
   ```

2. **Validate Package.json**
   ```bash
   # Check Node.js version requirement
   grep -A 2 '"engines"' frontend/package.json
   grep -A 2 '"engines"' package.json
   ```

3. **Test Docker Build Locally**
   ```bash
   docker build -t test-build .
   docker run -p 5000:5000 test-build
   ```

### Database Connection Issues:

1. **Verify Environment Variables**
   ```bash
   # Check DATABASE_URL format
   echo $DATABASE_URL
   
   # Should be: postgresql://user:password@host:port/database
   ```

2. **Test Database Connection**
   ```bash
   # In Coolify container shell
   npx prisma db push
   npx prisma studio
   ```

### M-Pesa Integration Issues:

1. **Check Callback URL**
   - Ensure callback URL is accessible from internet
   - Test with: `curl https://your-domain.com/api/mpesa/callback`

2. **Verify Credentials**
   - Double-check M-Pesa API keys
   - Ensure shortcode and passkey are correct

### MikroTik Integration Issues:

1. **Test API Access**
   ```bash
   # Test from container
   telnet YOUR_MIKROTIK_IP 8728
   ```

2. **Check Router Configuration**
   ```bash
   # In MikroTik terminal
   /ip service print
   /user print
   ```

## 📊 Monitoring and Logs

### Coolify Logs:
1. Go to your Coolify dashboard
2. Click on the application
3. View "Build Logs" for build errors
4. View "Application Logs" for runtime errors

### Application Health Checks:
```bash
# Test endpoints
curl https://your-domain.com/welcome
curl https://your-domain.com/health
curl https://your-domain.com/ready
```

### Database Status:
```bash
# Check database connection
curl https://your-domain.com/health | jq '.services.database'
```

## 🔄 Quick Fix Commands

### Reset Deployment:
1. In Coolify dashboard, click "Redeploy"
2. Or push a small change to trigger rebuild

### Clear Container Cache:
```bash
# In Coolify server terminal
docker system prune -f
docker volume prune -f
```

### Restart Services:
1. Go to Coolify dashboard
2. Click "Restart" on your application
3. Restart database service if needed

## 📋 Pre-Deployment Checklist

Before deploying to Coolify, ensure:

- [ ] Node.js version is 20+ in both package.json files
- [ ] Next.js config does not have static export enabled
- [ ] All environment variables are set in Coolify
- [ ] Database service is created and running
- [ ] M-Pesa callback URL is accessible
- [ ] MikroTik router is configured for API access

## 🆘 Getting Help

### Coolify Resources:
- [Coolify Documentation](https://coolify.io/docs)
- [Coolify Discord](https://discord.gg/coolify)
- [GitHub Issues](https://github.com/coollabsio/coolify/issues)

### Application Resources:
- Create GitHub issue for application bugs
- Check existing issues for similar problems
- Review application logs for specific errors

## 🚀 After Successful Deployment

Once deployed, verify:

1. **Application Health**
   - Visit `https://your-domain.com/health`
   - Check all services show as "connected" or "enabled"

2. **Frontend Loading**
   - Main page loads without errors
   - All CSS and JS files are loading

3. **API Endpoints**
   - Test payment endpoints
   - Verify admin dashboard functionality

4. **Database Operations**
   - User registration works
   - Payment records are saved

5. **External Integrations**
   - M-Pesa callbacks are received
   - MikroTik API commands work

---

**🎉 If you followed this guide and still have issues, please check the Coolify logs and create a GitHub issue with the specific error messages.**

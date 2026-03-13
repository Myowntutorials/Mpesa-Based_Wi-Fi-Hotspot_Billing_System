# 🚀 Coolify Quick Start Guide

## 📋 Pre-Deployment Checklist

Before deploying to Coolify, ensure you have:

- [ ] Forked the repository to your GitHub account
- [ ] Coolify instance (self-hosted or cloud)
- [ ] M-Pesa API credentials from Safaricom
- [ ] MikroTik router details (IP, username, password)
- [ ] Custom domain (optional but recommended)

## ⚡ One-Click Deployment Steps

### 1. Repository Setup
```bash
# Fork and clone (replace YOUR_USERNAME)
git clone https://github.com/YOUR_USERNAME/Mpesa-Based_Wi-Fi-Hotspot_Billing_System.git
cd Mpesa-Based_Wi-Fi-Hotspot_Billing_System
```

### 2. Coolify Configuration
The following files are pre-configured for Coolify:
- ✅ `coolify.yaml` - Main configuration
- ✅ `docker-compose.coolify.yml` - Docker setup
- ✅ `.env.production` - Environment template
- ✅ `Dockerfile` - Optimized for production

### 3. Coolify Dashboard Setup

1. **New Project**
   - Click "New Project" → "From Git Repository"
   - Select your forked repository
   - Choose branch: `main`

2. **Application Settings**
   ```
   Name: M-Pesa WiFi Hotspot
   Build Mode: Docker
   Port: 5000
   Health Check: /health
   ```

3. **Database Service**
   - Add PostgreSQL service
   - Name: `wifi-billing-db`
   - Version: `15`

4. **Environment Variables**
   Add these in project settings:
   ```bash
   # Security
   JWT_SECRET=your-super-secure-jwt-secret
   ADMIN_USERNAME=admin
   ADMIN_PASSWORD=your-secure-password
   ADMIN_EMAIL=admin@yourdomain.com
   
   # M-Pesa
   MPESA_ENABLED=true
   MPESA_CONSUMER_KEY=your_mpesa_key
   MPESA_CONSUMER_SECRET=your_mpesa_secret
   MPESA_SHORTCODE=your_shortcode
   MPESA_PASSKEY=your_passkey
   MPESA_CALLBACK_URL=https://your-domain.com/api/mpesa/callback
   
   # MikroTik
   MIKROTIK_ENABLED=true
   MIKROTIK_HOST=192.168.88.1
   MIKROTIK_USER=admin
   MIKROTIK_PASSWORD=your_mikrotik_password
   MIKROTIK_PORT=8728
   
   # Loan
   LOAN_WIFI_DURATION_HOURS=1
   ```

### 4. Deploy
- Click "Deploy" and wait for completion
- Monitor build logs in Coolify dashboard
- Test endpoints:
  - `https://your-domain.com/welcome`
  - `https://your-domain.com/health`
  - `https://your-domain.com/ready`

## 🔍 Post-Deployment Verification

### Test Core Features
1. **Application Health**
   ```bash
   curl https://your-domain.com/health
   # Expected: {"status":"healthy","timestamp":"..."}
   ```

2. **M-Pesa Integration**
   - Access payment interface
   - Test STK push with real phone number
   - Verify callback receives response

3. **MikroTik Integration**
   - Check network status page
   - Verify device detection
   - Test user management

### Monitoring
- Coolify automatically monitors `/health` endpoint
- Check resource usage in dashboard
- Monitor logs for any errors

## 🛠️ Troubleshooting Quick Fixes

### Build Issues
- Check Dockerfile syntax
- Verify all dependencies in package.json
- Review build logs

### Database Issues
- Verify DATABASE_URL format
- Check database service status
- Confirm credentials

### M-Pesa Issues
- Update callback URL in Safaricom portal
- Check firewall allows incoming callbacks
- Verify API credentials

### MikroTik Issues
- Ensure API service enabled: `/ip service enable api`
- Check port 8728 is accessible
- Verify credentials

## 📚 Important Files

| File | Purpose |
|------|---------|
| `coolify.yaml` | Main Coolify configuration |
| `docker-compose.coolify.yml` | Docker setup for Coolify |
| `.env.production` | Environment variables template |
| `Dockerfile` | Optimized for production |
| `DEPLOYMENT_COOLIFY.md` | Detailed deployment guide |

## 🎯 Next Steps

1. **Security**: Change all default passwords and secrets
2. **Domain**: Configure custom domain and SSL
3. **Backups**: Set up automated database backups
4. **Monitoring**: Configure alerts for health checks
5. **Testing**: Thoroughly test all features

## 📞 Need Help?

- **Coolify Docs**: https://coolify.io/docs
- **Application Issues**: Create GitHub issue
- **M-Pesa Support**: Safaricom Developer Portal
- **MikroTik Docs**: https://wiki.mikrotik.com

---

**🎉 Your M-Pesa Wi-Fi Hotspot Billing System is ready for Coolify deployment!**

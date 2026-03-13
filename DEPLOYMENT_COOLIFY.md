# Deploy M-Pesa Wi-Fi Hotspot Billing System on Coolify

This guide provides step-by-step instructions for deploying the M-Pesa Wi-Fi Hotspot Billing System on Coolify.

## 🚀 Prerequisites

- **Coolify Instance**: Self-hosted or cloud-hosted Coolify instance
- **Git Repository**: Your fork of the M-Pesa Wi-Fi Hotspot Billing System
- **Domain**: Custom domain (recommended) or use Coolify's provided domain
- **M-Pesa API**: Access to Safaricom M-Pesa API credentials
- **MikroTik Router**: Configured router with API access (optional but recommended)

## 📋 Step 1: Prepare Your Repository

1. **Fork the Repository**
   ```bash
   # Fork the original repository to your GitHub account
   # Clone your fork locally
   git clone https://github.com/YOUR_USERNAME/Mpesa-Based_Wi-Fi-Hotspot_Billing_System.git
   cd Mpesa-Based_Wi-Fi-Hotspot_Billing_System
   ```

2. **Verify Coolify Configuration Files**
   - `coolify.yaml` - Main Coolify configuration
   - `docker-compose.coolify.yml` - Docker Compose for Coolify
   - `.env.production` - Environment variables template
   - `Dockerfile` - Updated for Coolify compatibility

## 🔧 Step 2: Set Up Coolify Project

1. **Log into Coolify Dashboard**
   - Navigate to your Coolify instance
   - Log in with your credentials

2. **Create New Project**
   - Click "New Project" → "From Git Repository"
   - Connect your GitHub account
   - Select your forked repository
   - Choose the branch (usually `main` or `master`)

3. **Configure Application Settings**
   ```
   Application Name: M-Pesa WiFi Hotspot
   Build Mode: Docker
   Dockerfile Path: ./Dockerfile
   Port: 5000
   ```

4. **Set Up Database**
   - Click "Add Service" → "PostgreSQL"
   - Configure database:
     ```
     Name: wifi-billing-db
     Version: 15
     Database Name: wifi_billing
     User: wifi_user
     ```
   - Note the database password for later use

## 🔐 Step 3: Configure Environment Variables

In your Coolify project settings, add the following environment variables:

### Required Variables
```bash
# Security
JWT_SECRET=your-super-secure-random-jwt-secret-here
ADMIN_USERNAME=admin
ADMIN_PASSWORD=your-secure-admin-password
ADMIN_EMAIL=admin@yourdomain.com

# Database (Coolify will auto-set DATABASE_URL)
DB_PASSWORD=your-database-password

# M-Pesa Integration
MPESA_ENABLED=true
MPESA_CONSUMER_KEY=your_mpesa_consumer_key
MPESA_CONSUMER_SECRET=your_mpesa_consumer_secret
MPESA_SHORTCODE=your_mpesa_shortcode
MPESA_PASSKEY=your_mpesa_passkey
MPESA_CALLBACK_URL=https://your-domain.com/api/mpesa/callback

# MikroTik Integration
MIKROTIK_ENABLED=true
MIKROTIK_HOST=192.168.88.1
MIKROTIK_USER=your_mikrotik_username
MIKROTIK_PASSWORD=your_mikrotik_password
MIKROTIK_PORT=8728

# Loan Configuration
LOAN_WIFI_DURATION_HOURS=1
```

### Optional Variables
```bash
# Additional MikroTik Admin
MIKROTIK_ADMIN_USERNAME=admin
MIKROTIK_ADMIN_PASSWORD=admin123

# Logging
LOG_LEVEL=info
```

## 🌐 Step 4: Configure Domain and SSL

1. **Add Custom Domain** (Recommended)
   - In project settings, click "Add Domain"
   - Enter your domain (e.g., `wifi.yourdomain.com`)
   - Coolify will automatically provision SSL certificate

2. **Or Use Coolify Domain**
   - Coolify provides a subdomain automatically
   - Format: `your-project-name.your-coolify-domain.com`

## 🚀 Step 5: Deploy the Application

1. **Initial Deployment**
   - Click "Deploy" in Coolify dashboard
   - Monitor the build logs
   - Wait for deployment to complete

2. **Health Checks**
   - Coolify will automatically monitor `/health` endpoint
   - Check deployment status in the dashboard
   - Verify the application is running

3. **Test the Application**
   ```bash
   # Test basic endpoints
   curl https://your-domain.com/welcome
   curl https://your-domain.com/health
   curl https://your-domain.com/ready
   ```

## 📱 Step 6: Configure M-Pesa Integration

1. **Update M-Pesa Callback URL**
   - Log into Safaricom Developer Portal
   - Update your app's callback URL to: `https://your-domain.com/api/mpesa/callback`

2. **Test M-Pesa Integration**
   - Use the application's payment interface
   - Verify STK push functionality
   - Check callback reception in logs

## 🖥️ Step 7: Configure MikroTik Integration

1. **Enable MikroTik API**
   ```bash
   # Connect to your MikroTik router
   /ip service enable api
   /ip service set api port=8728
   ```

2. **Test Connection**
   - Use the application's network status page
   - Verify device detection
   - Test user disconnection functionality

## 🔍 Step 8: Monitoring and Maintenance

### Health Monitoring
- Coolify automatically monitors `/health` endpoint
- Check application status in dashboard
- Monitor resource usage (CPU, Memory, Disk)

### Log Management
```bash
# View application logs in Coolify dashboard
# Or SSH into the server for detailed logs
docker logs -f your-container-name
```

### Database Management
- Access database via Coolify's phpMyAdmin (if enabled)
- Or connect directly:
```bash
psql -h localhost -U wifi_user -d wifi_billing
```

## 🛠️ Troubleshooting

### Common Issues

1. **Build Failures**
   - Check Dockerfile syntax
   - Verify all dependencies are in package.json
   - Review build logs in Coolify

2. **Database Connection Issues**
   - Verify DATABASE_URL format
   - Check database service is running
   - Confirm credentials match

3. **M-Pesa Callback Issues**
   - Ensure callback URL is accessible from internet
   - Check firewall settings
   - Verify M-Pesa credentials

4. **MikroTik Connection Issues**
   - Verify router IP and credentials
   - Check API port (8728) is open
   - Ensure API service is enabled on router

### Performance Optimization

1. **Database Optimization**
   ```sql
   -- Create indexes for better performance
   CREATE INDEX idx_payment_status ON payments(status);
   CREATE INDEX idx_user_phone ON users(phone);
   ```

2. **Application Scaling**
   - Enable horizontal scaling in Coolify
   - Add load balancer if needed
   - Consider Redis for session storage

## 🔄 Updates and Maintenance

### Updating the Application
1. Push changes to your Git repository
2. Coolify will automatically detect and redeploy
3. Monitor deployment logs
4. Verify functionality after update

### Database Backups
- Configure automated backups in Coolify
- Or manually backup:
```bash
docker exec postgres_container pg_dump -U wifi_user wifi_billing > backup.sql
```

## 📊 Monitoring Metrics

Key metrics to monitor:
- Application response time
- Database connection pool usage
- M-Pesa transaction success rate
- Active user sessions
- MikroTik API response time

## 🔒 Security Considerations

1. **Regular Updates**
   - Keep Node.js dependencies updated
   - Update base Docker images
   - Monitor security advisories

2. **Access Control**
   - Use strong admin passwords
   - Enable two-factor authentication on Coolify
   - Restrict API access with firewalls

3. **Data Protection**
   - Encrypt sensitive data at rest
   - Use HTTPS for all communications
   - Regular security audits

## 📞 Support

For issues related to:
- **Coolify Platform**: Check Coolify documentation
- **Application**: Create GitHub issue in repository
- **M-Pesa Integration**: Contact Safaricom Developer Support
- **MikroTik**: Consult MikroTik documentation

---

## 🎉 Deployment Complete!

Your M-Pesa Wi-Fi Hotspot Billing System is now running on Coolify! 

**Next Steps:**
1. Test all payment flows
2. Verify MikroTik integration
3. Set up monitoring alerts
4. Configure backup strategies
5. Document your custom configurations

**Access URLs:**
- Main Application: `https://your-domain.com`
- Health Check: `https://your-domain.com/health`
- Admin Dashboard: `https://your-domain.com/admin`

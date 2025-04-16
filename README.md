# Multi-Tenant Blog Application

A Ruby on Rails application that provides a multi-tenant blogging platform where different organizations can have their own isolated blog spaces.

## Prerequisites

- Ruby 3.1.2
- PostgreSQL

## Getting Started

### Local Development

1. Clone the repository:
   git clone <repository-url>
   cd multi_tenant_blog

2. Install dependencies:
   bundle install

3. Set up the database:
   rails db:create
   rails db:migrate
   rails db:seed  # Creates sample organizations: Acme and Manic

4. Add sub domains to /etc/hosts:
   127.0.0.1       acme.localhost
   127.0.0.1       manic.localhost

5. Start the development server:
   rails server

6. Create users for Acme and Manic hosts:
   - Acme: http://acme.lvh.me:3000/users/sign_up
   - Manic: http://manic.lvh.me:3000/sign_up

7. You can access the organizations posts dashboard at:
   - Acme: http://acme.lvh.me:3000/posts
   - Manic: http://manic.lvh.me:3000/posts

## Features

- Multi-tenant architecture with isolated blog spaces
- User authentication and authorization
- Blog post management
- Hotwire-powered real-time updates

## Trade-offs and Assumptions

1. **Database Design**:
   - Used PostgreSQL for its robust multi-tenant capabilities
   - Chose schema-based multi-tenancy for better isolation

2. **Authentication**:
   - Implemented Devise for user authentication
   - Assumed email-based authentication would be sufficient
   - No social login integration (could be added later)

3. **Performance**:
   - Used Hotwire for real-time updates instead of WebSockets
   - Assumed moderate traffic per organization
   - No caching layer implemented (could be added with Redis)

## Future Enhancements

1. **Advanced Features**:
   - Social login integration (Google, GitHub, etc.)
   - Image upload and processing
   - Search functionality
   - Analytics dashboard

2. **Performance Improvements**:
   - Redis caching layer
   - Background job processing with Sidekiq
   - CDN integration for static assets
   - Database query optimization

3. **Security Enhancements**:
   - Rate limiting
   - Advanced role-based access control
   - Audit logging
   - Two-factor authentication

## AI Tooling Usage

The development of this application utilized AI assistance for:
- Code generation for styling the view pages.

## Testing

Run the test suite:
   bundle exec rspec

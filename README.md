# create-nfdd

Bootstrap enterprise-grade, full-stack TypeScript monorepo projects with the NFDD stack (Next.js + Fastify + Drizzle + Docker).

## What is NFDD?

NFDD is an opinionated, production-ready starter template for building scalable web applications with:

- **Next.js 15** (React 19, App Router, Turbopack)
- **Fastify 5** (High-performance API framework)
- **Drizzle ORM** (Type-safe database toolkit)
- **Docker Compose** (Containerized development & deployment)
- **PostgreSQL 18** (Reliable relational database)
- **pnpm Workspace** (Efficient monorepo management)

## Quick Start

### Using npx (Recommended)

```bash
npx create-nfdd my-app
cd my-app
docker compose -f docker-compose.dev.yml up -d
```

### Using pnpm

```bash
pnpm create nfdd my-app
cd my-app
docker compose -f docker-compose.dev.yml up -d
```

### Using npm

```bash
npm init nfdd my-app
cd my-app
docker compose -f docker-compose.dev.yml up -d
```

## What You'll Get

A fully configured monorepo with:

```
my-app/
├── apps/
│   ├── backend-api/      # Fastify REST API with Swagger docs
│   └── web-client/       # Next.js frontend with type-safe API client
├── packages/
│   └── database/         # Shared Drizzle ORM package with DAO pattern
├── docker-compose.dev.yml
├── docker-compose.prod.yml
└── README.md             # Comprehensive documentation
```

### Key Features

✅ **Full-Stack TypeScript** - Type safety from database to frontend
✅ **Docker First** - Consistent dev/prod environments
✅ **Auto-Migrations** - Database evolves with your code
✅ **DAO Pattern** - Clean separation of database logic
✅ **OpenAPI Integration** - Generate frontend types from backend API
✅ **Hot Reload** - Fast development with tsx and Turbopack
✅ **Production Ready** - Separate dev/prod configurations
✅ **Comprehensive Docs** - Includes Spec Kit constitution guide

## Interactive Setup

When you run `create-nfdd`, you'll be prompted for:

- **Project name** - Your application name
- **Description** - Brief project description
- **Author** - Your name
- **Email** - Your email address
- **License** - Project license (MIT, ISC, etc.)
- **Database name** - PostgreSQL database name (default: `app_db`)
- **API Port** - Backend API port (default: `3001`)
- **Web Port** - Frontend port (default: `3000`)

## After Creation

Your project will be ready with:

1. **Development Environment**
   ```bash
   docker compose -f docker-compose.dev.yml up -d
   ```
   - Frontend: http://localhost:3000
   - Backend API: http://localhost:3001
   - API Docs: http://localhost:3001/docs

2. **Example Features**
   - Health check endpoint
   - CRUD API for "people" resource
   - Searchable table with pagination
   - Type-safe API calls from frontend

3. **Automatic Setup**
   - Database migrations run on startup
   - Seed data inserted if database is empty
   - CORS configured for frontend

## Architecture Highlights

### DAO Pattern
All database access goes through Data Access Objects for clean separation:
```typescript
// ❌ Don't do this
import { db, people } from '@repo/database';
const person = await db.select().from(people).where(...);

// ✅ Do this
import { peopleDAO } from '@repo/database';
const person = await peopleDAO.findById(id);
```

### Schema Separation
- **Drizzle schemas** define database structure
- **TypeBox schemas** define API validation
- Both are kept in the shared `@repo/database` package

### Type Generation Flow
```
Drizzle → Database Types
TypeBox → Fastify Routes → OpenAPI Spec
OpenAPI Spec → Frontend Types (openapi-typescript)
```

## Next Steps

After creating your project:

1. **Read the README** - Comprehensive guide in your project root
2. **Explore the code** - Start with the people CRUD example
3. **Add your entities** - Follow the 10-step guide in README
4. **Customize** - Adapt to your needs

## Documentation

Your generated project includes:

- Complete setup guide
- Database management tutorials
- API development patterns
- Frontend integration examples
- Deployment instructions
- **Spec Kit Constitution Guide** - For generating project specifications

## Use with GitHub Spec Kit

The generated README includes a "Spec Kit Constitution Guide" section designed for use with [GitHub Spec Kit](https://github.com/github/spec-kit) to generate project constitution documents that follow NFDD patterns.

## Requirements

- **Docker Desktop** (or Docker Engine + Docker Compose)
- **Node.js 18+** (for local type generation)
- **pnpm 8+** (recommended, but npm/yarn work too)

## Tech Stack Details

| Technology | Version | Purpose |
|------------|---------|---------|
| Next.js | 15.x | React framework with App Router |
| React | 19.x | UI library |
| Fastify | 5.x | High-performance API framework |
| Drizzle ORM | 0.44+ | Type-safe database toolkit |
| PostgreSQL | 18 Alpine | Relational database |
| TypeScript | 5.x | Type-safe JavaScript |
| Docker | Latest | Containerization |
| pnpm | 10.x | Fast package manager |
| Tailwind CSS | 4.x | Utility-first CSS |
| TypeBox | Latest | JSON schema validation |
| pino-pretty | Latest | Beautiful logging |

## Example Project

The starter includes a fully functional CRUD example for managing "people" records:

- **Backend**: REST API with validation
- **Frontend**: Searchable table with pagination
- **Database**: Auto-migrated schema with seed data
- **Types**: End-to-end type safety

## Contributing

Found a bug or have a suggestion? Open an issue on [GitHub](https://github.com/YOUR_USERNAME/create-nfdd).

## License

MIT

## Author

Lyle Classen

---

**Happy coding!** 🚀

Generate your next enterprise application in seconds with `create-nfdd`.

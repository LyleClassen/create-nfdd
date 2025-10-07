#!/usr/bin/env node

import { resolve } from 'path';
import { create } from 'create-create-app';

create('create-nfdd', {
  templateRoot: resolve(__dirname, '..', 'templates'),
  defaultTemplate: 'default',
  promptForDescription: true,
  promptForAuthor: true,
  promptForEmail: true,
  promptForLicense: true,
  promptForTemplate: false,
  extra: {
    database: {
      type: 'input',
      describe: 'Database name',
      default: 'app_db',
      prompt: 'if-no-arg',
    },
    apiPort: {
      type: 'input',
      describe: 'Backend API port',
      default: '3001',
      prompt: 'if-no-arg',
    },
    webPort: {
      type: 'input',
      describe: 'Frontend web client port',
      default: '3000',
      prompt: 'if-no-arg',
    },
  },
  after: ({ answers }) => {
    console.log('\n✅ Project created successfully!\n');
    console.log('📦 Next steps:\n');
    console.log(`   cd ${answers.name}`);
    console.log('   docker compose -f docker-compose.dev.yml up -d\n');
    console.log('🚀 Your application will be available at:');
    console.log(`   Frontend: http://localhost:${answers.apiPort || '3000'}`);
    console.log(`   Backend:  http://localhost:${answers.webPort || '3001'}`);
    console.log(`   API Docs: http://localhost:${answers.webPort || '3001'}/docs\n`);
    console.log('📚 Read the README.md for more information.\n');
  },
  caveat: ({ answers }) => {
    return `
🎯 ${answers.name} is ready!

⚠️  Important Notes:
  • Update production passwords in .env.prod before deploying
  • Configure CORS_ORIGIN for your production domain
  • Review the README.md for complete documentation
  • The Spec Kit Constitution Guide section helps with project specifications

💡 Pro Tips:
  • Use docker compose for consistent development
  • Run database migrations automatically on container start
  • Generate OpenAPI types for type-safe frontend API calls
  • All database access goes through DAO pattern

Happy coding! 🚀
    `.trim();
  },
});

#!/usr/bin/env node
const process = require('process');
const child_process = require('child_process');
const [bin, ...flags] = process.argv.slice(2);

const stdin = process.openStdin();
const child = child_process.spawn(bin, flags, { detached: true });

const endAll = () => {
  process.kill(-child.pid);
  process.exit(0);
};

child.stderr.on('data', (data) => console.error(data.toString('utf8')));
child.stdout.on('data', (data) => console.log(data.toString('utf8')));

stdin.on('end', endAll);
process.on('SIGINT', endAll);

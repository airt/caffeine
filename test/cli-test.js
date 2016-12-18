
import test from 'ava'
import path from 'path'
import { run } from '../lib/cli'

test('run', t => {
  t.notThrows(() => {
    const args = [
      process.argv[0],
      path.resolve(__dirname, '../bin/caffeine'),
      '-o',
      '-s',
      '-u',
      'http://example.org,http://localhost:404',
    ]
    run(args)
  })
})

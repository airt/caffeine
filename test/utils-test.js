
import test from 'ava'
import { createCounter, now, randomInRange, stringContains } from '../lib/utils'

test('createCounter', t => {
  let count = createCounter()
  t.is(typeof count, 'function')
  t.is(count(), 1)
  t.is(count(), 2)
  count = createCounter(-2)
  t.is(count(), -1)
  t.is(count(), 0)
})

test('now', t => {
  t.regex(now(), /[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}/)
})

test('randomInRange', t => {
  t.true(randomInRange(1, 10) >= 1)
  t.true(randomInRange(1, 10) < 10)
})

test('stringContains', t => {
  t.true(stringContains('abc', 'c'))
  t.false(stringContains('abc', 'x'))
})

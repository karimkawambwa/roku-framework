' For all easing functions:
' t = elapsed time
' b = begin
' c = change = ending - beginning
' d = duration (total time)

function linear(t, b, c, d)
  return c * t / d + b
end function

function inQuad(t, b, c, d)
  t = t / d
  return c * pow(t, 2) + b
end function

function outQuad(t, b, c, d)
  t = t / d
  return -c * t * (t - 2) + b
end function

function inOutQuad(t, b, c, d)
  t = t / d * 2
  if t < 1 then
    return c / 2 * pow(t, 2) + b
  else
    return -c / 2 * ((t - 1) * (t - 3) - 1) + b
  end if
end function

function outInQuad(t, b, c, d)
  if t < d / 2 then
    return outQuad (t * 2, b, c / 2, d)
  else
    return inQuad((t * 2) - d, b + c / 2, c / 2, d)
  end if
end function

function inCubic (t, b, c, d)
  t = t / d
  return c * pow(t, 3) + b
end function

function outCubic(t, b, c, d)
  t = t / d - 1
  return c * (pow(t, 3) + 1) + b
end function

function inOutCubic(t, b, c, d)
  t = t / d * 2
  if t < 1 then
    return c / 2 * t * t * t + b
  else
    t = t - 2
    return c / 2 * (t * t * t + 2) + b
  end if
end function

function outInCubic(t, b, c, d)
  if t < d / 2 then
    return outCubic(t * 2, b, c / 2, d)
  else
    return inCubic((t * 2) - d, b + c / 2, c / 2, d)
  end if
end function

function inQuart(t, b, c, d)
  t = t / d
  return c * pow(t, 4) + b
end function

function outQuart(t, b, c, d)
  t = t / d - 1
  return -c * (pow(t, 4) - 1) + b
end function

function inOutQuart(t, b, c, d)
  t = t / d * 2
  if t < 1 then
    return c / 2 * pow(t, 4) + b
  else
    t = t - 2
    return -c / 2 * (pow(t, 4) - 2) + b
  end if
end function

function outInQuart(t, b, c, d)
  if t < d / 2 then
    return outQuart(t * 2, b, c / 2, d)
  else
    return inQuart((t * 2) - d, b + c / 2, c / 2, d)
  end if
end function

function inQuint(t, b, c, d)
  t = t / d
  return c * pow(t, 5) + b
end function

function outQuint(t, b, c, d)
  t = t / d - 1
  return c * (pow(t, 5) + 1) + b
end function

function inOutQuint(t, b, c, d)
  t = t / d * 2
  if t < 1 then
    return c / 2 * pow(t, 5) + b
  else
    t = t - 2
    return c / 2 * (pow(t, 5) + 2) + b
  end if
end function

function outInQuint(t, b, c, d)
  if t < d / 2 then
    return outQuint(t * 2, b, c / 2, d)
  else
    return inQuint((t * 2) - d, b + c / 2, c / 2, d)
  end if
end function

function inSine(t, b, c, d)
  return -c * cos(t / d * (pi / 2)) + c + b
end function

function outSine(t, b, c, d)
  return c * sin(t / d * (pi / 2)) + b
end function

function inOutSine(t, b, c, d)
  return -c / 2 * (cos(pi * t / d) - 1) + b
end function

function outInSine(t, b, c, d)
  if t < d / 2 then
    return outSine(t * 2, b, c / 2, d)
  else
    return inSine((t * 2) -d, b + c / 2, c / 2, d)
  end if
end function

function inExpo(t, b, c, d)
  if t = 0 then
    return b
  else
    return c * pow(2, 10 * (t / d - 1)) + b - c * 0.001
  end if
end function

function outExpo(t, b, c, d)
  if t = d then
    return b + c
  else
    return c * 1.001 * (-pow(2, -10 * t / d) + 1) + b
  end if
end function

function inOutExpo(t, b, c, d)
  if t = 0 then return b
  if t = d then return b + c
  t = t / d * 2
  if t < 1 then
    return c / 2 * pow(2, 10 * (t - 1)) + b - c * 0.0005
  else
    t = t - 1
    return c / 2 * 1.0005 * (-pow(2, -10 * t) + 2) + b
  end if
end function

function outInExpo(t, b, c, d)
  if t < d / 2 then
    return outExpo(t * 2, b, c / 2, d)
  else
    return inExpo((t * 2) - d, b + c / 2, c / 2, d)
  end if
end function

function inCirc(t, b, c, d)
  t = t / d
  return(-c * (sqrt(1 - pow(t, 2)) - 1) + b)
end function

function outCirc(t, b, c, d)
  t = t / d - 1
  return(c * sqrt(1 - pow(t, 2)) + b)
end function

function inOutCirc(t, b, c, d)
  t = t / d * 2
  if t < 1 then
    return -c / 2 * (sqrt(1 - t * t) - 1) + b
  else
    t = t - 2
    return c / 2 * (sqrt(1 - t * t) + 1) + b
  end if
end function

function outInCirc(t, b, c, d)
  if t < d / 2 then
    return outCirc(t * 2, b, c / 2, d)
  else
    return inCirc((t * 2) - d, b + c / 2, c / 2, d)
  end if
end function

function inElastic(t, b, c, d, a, p)
  if t = 0 then return b

  t = t / d

  if t = 1  then return b + c

  if not p then p = d * 0.3

  if not a or a < abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * pi) * asin(c/a)
  end if

  t = t - 1

  return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
end function

' @param a: amplitude
' @param p: period
function outElastic(t, b, c, d, a, p)
  if t = 0 then return b

  t = t / d

  if t = 1 then return b + c

  if not p then p = d * 0.3

  if not a or a < abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * pi) * asin(c/a)
  end if

  return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p) + c + b
end function

' @param p = period
' @param a = amplitude
function inOutElastic(t, b, c, d, a, p)
  if t = 0 then return b

  t = t / d * 2

  if t = 2 then return b + c

  if not p then p = d * (0.3 * 1.5)
  if not a then a = 0

  if not a or a < abs(c) then
    a = c
    s = p / 4
  else
    s = p / (2 * pi) * asin(c / a)
  end if

  if t < 1 then
    t = t - 1
    return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
  else
    t = t - 1
    return a * pow(2, -10 * t) * sin((t * d - s) * (2 * pi) / p ) * 0.5 + c + b
  end if
end function

' @param a: amplitude
' @param p: period
function outInElastic(t, b, c, d, a, p)
  if t < d / 2 then
    return outElastic(t * 2, b, c / 2, d, a, p)
  else
    return inElastic((t * 2) - d, b + c / 2, c / 2, d, a, p)
  end if
end function

function inBack(t, b, c, d, s)
  if s = invalid then s = 1.70158
  t = t / d
  return c * t * t * ((s + 1) * t - s) + b
end function

function outBack(t, b, c, d, s)
  if s = invalid then s = 1.70158
  t = t / d - 1
  return c * (t * t * ((s + 1) * t + s) + 1) + b
end function

function inOutBack(t, b, c, d, s)
  if s = invalid then s = 1.70158
  s = s * 1.525
  t = t / d * 2
  if t < 1 then
    return c / 2 * (t * t * ((s + 1) * t - s)) + b
  else
    t = t - 2
    return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
  end if
end function

function outInBack(t, b, c, d, s)
  if t < d / 2 then
    return outBack(t * 2, b, c / 2, d, s)
  else
    return inBack((t * 2) - d, b + c / 2, c / 2, d, s)
  end if
end function

function outBounce(t, b, c, d)
  t = t / d
  if t < 1 / 2.75 then
    return c * (7.5625 * t * t) + b
  else if t < 2 / 2.75 then
    t = t - (1.5 / 2.75)
    return c * (7.5625 * t * t + 0.75) + b
  else if t < 2.5 / 2.75 then
    t = t - (2.25 / 2.75)
    return c * (7.5625 * t * t + 0.9375) + b
  else
    t = t - (2.625 / 2.75)
    return c * (7.5625 * t * t + 0.984375) + b
  end if
end function

function inBounce(t, b, c, d)
  return c - outBounce(d - t, 0, c, d) + b
end function

function inOutBounce(t, b, c, d)
  if t < d / 2 then
    return inBounce(t * 2, 0, c, d) * 0.5 + b
  else
    return outBounce(t * 2 - d, 0, c, d) * 0.5 + c * .5 + b
  end if
end function

function outInBounce(t, b, c, d)
  if t < d / 2 then
    return outBounce(t * 2, b, c / 2, d)
  else
    return inBounce((t * 2) - d, b + c / 2, c / 2, d)
  end if
end function

function pow(a, b)
    return a ^ b
end function
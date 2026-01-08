#!/bin/bash

while true; do
  powershell.exe -NoProfile -Command "
  Add-Type -AssemblyName System.Windows.Forms;
  Add-Type -AssemblyName System.Drawing;

  \$pos = [System.Windows.Forms.Cursor]::Position

  # move mouse 50 pixels to the right
  \$x = \$pos.X + 50
  \$y = \$pos.Y

  [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point(\$x, \$y)

  Start-Sleep -Milliseconds 300

  # move it back
  [System.Windows.Forms.Cursor]::Position = \$pos
  "
  sleep 30
done


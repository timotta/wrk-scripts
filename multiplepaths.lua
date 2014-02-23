counter = 0

function file_exists(file)
  local f = io.open(file, "rb")
  if f then f:close() end
  return f ~= nil
end

function non_empty_lines_from(file)
  if not file_exists(file) then return {} end
  lines = {}
  for line in io.lines(file) do 
    if not (line == '') then
      lines[#lines + 1] = line
    end
  end
  return lines
end

paths = non_empty_lines_from("paths.txt")

if #paths <= 0 then
  print("multiplepaths: No paths found. You have to create a file paths.txt with one path per line")
  os.exit()
end
  
print("multiplepaths: Found " .. #paths .. " paths")

request = function()
    path = paths[counter]
    counter = counter + 1
    if counter > #paths then
      counter = 0
    end
    return wrk.format(nil, path)
end

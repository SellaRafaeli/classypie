not_found do
	{status: 404, msg: "Not Found", custom: "helium-12"}
end

error do
  e = env['sinatra.error']
  {status: 500, msg: e.to_s, custom: "barrium-1776", backtrace: e.backtrace.to_a.slice(0,4).to_s}
end

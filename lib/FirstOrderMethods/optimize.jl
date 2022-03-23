function optimize(method::DescentMethod, f::Function, ∇f::Function, x0::Vector{Float64}; iteration::Int64 = 100)
	pts = [x0]
	for _ = 1:iteration
		push!(pts, step!(method, f, ∇f, pts[end]))
	end
	return pts
end


#' Wong, Tommy SW. "Discussion of" Explicit solutions of the Manning equation
#' for partially filled circular pipes"(1)." Canadian Journal of Civil
#' Engineering 33.3 (2006): 349-353.
var_n_factor <- function(theta) {
  1 + 0.005 * theta^1.2 * (2 * pi - theta)^2.2
}
#
# get_theta <- function(h, diameter) {
#   2 * acos(1 - (2 * as.numeric(h / diameter)))
# }
#
# # area = (radius^2 / 2) * (theta - sin(theta))
# circle_segment_area <- function(h, diameter) {
#   theta <- segment_central_angle(h, diameter)
#   area <- (self$radius^2 / 2) * (theta - sin(theta))
#   return(area)
# }

# Public Function CircWP(DiaFt As Double, DepthFt As Double) As Double
# Dim a As Double
# a = alpha(DiaFt, DepthFt)
# CircWP = a * 0.5 * DiaFt
#
# End Function
# https://en.wikipedia.org/wiki/Circular_segment#Arc_length_and_area
# arc length = theta * radius = theta (diameter/2)
# circle_wetted_perimeter <- function(h, diameter) {
#   theta <- get_theta(h, diameter)
#   theta * diameter / 2
# }
#
#
# Public Function CircFlow(DiaFt As Double, DepthFt As Double, n As Double, SlopeFtperFt As Double) As Double
# If DiaFt <= 0 Or DepthFt <= 0 Or n <= 0 Or SlopeFtperFt <= 0 Then
# CircFlow = 0
# Else
# CircFlow = (1.49 / n) * CircArea(DiaFt, DepthFt) * (CircArea(DiaFt, DepthFt) / CircWP(DiaFt, DepthFt)) ^ (2 / 3) * SlopeFtperFt ^ 0.5
# End If
#

#
# End Function
#
# Private Sub CalcMinV()
# Dim i As Long
# '
# ' Macro1 Macro
# ' Macro recorded 3/22/02 by DJC Eng
# '
#
# '
#     Dim startcalc As Integer
#
#     startcalc = 5
#
#     i = startcalc
#     MsgBox Range("A" & CStr(i)).Value, vbOKOnly, "Starting Diameter"
#
#
#     Do While Range("A" & CStr(i)).Value <> 0
#         'MsgBox Range("A" & CStr(i))  .Value
# Range("e" & CStr(i)).GoalSeek Goal:=0, ChangingCell:=Range("c" & CStr(i))
# Range("DepthFt" & CStr(i)).GoalSeek Goal:=0, ChangingCell:=Range("f" & CStr(i))
#
# i = i + 1
# Loop
#
#
# 'Range("F5").Select
#     'Range("F6").GoalSeek Goal:=0, ChangingCell:=Range("E6")
# End Sub
#
# Function CircT(ByVal D As Double, H As Double) As Double
# If D <= 0 Or H <= 0 Then
# CircT = -1
# Else
# If H >= D Then
# CircT = 0
# Else
# CircT = 2 * (H * (D - H)) ^ 0.5
# End If
#
# End If
#
# End Function
#
# Function CircQc(ByVal D As Double, H As Double) As Double
# 'See Chow "Open Channel Hydraulics" Page 81 Equation 4-21
#     Dim a As Double
#     a = alpha(D, H)
#     CircQc = (0.251 * (a - Sin(a)) ^ 1.5 / (Sin(a / 2)) ^ 0.5) * D ^ 2.5
#
# End Function

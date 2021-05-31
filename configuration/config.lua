Config = {
	OpenCommand = 'weaponapps', -- The key to open UI menu (Leave blank if you dont want to open with command)
	SubmitLocation = {
		x=1,
		y=2,
		z=3,
	},
	MinimumJobRank = '4', -- Minimum job rank to view/accept/deny weapon applications, set to 1 to allow all PD to do it.
	PaymentAmount = '2000' -- Amount the individual will pay for a weapon license
}

-- Only change if you know what are you doing!
function SendMessage(msg)
		exports['mythic_notify']:SendAlert('inform', msg)
end



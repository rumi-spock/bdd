Feature:
	IN ORDER to allow customers to remove their payment methods from the mobile “my account” portal
	AS a Skybet 
	I WANT to be able to update status of a payment method from My Account

	* Credit cards and Debit cards are all “card payment methods” (type = CC)
	* eWallet are payment methods like paypal, moneybookers etc

	@FEATURE_payment @FEATURE_update_method
	Scenario Outline: Set an active payment method status as Dormant by default
		GIVEN I am an active customer
		AND I have an active payment method "<method_1>"
		WHEN I attempt to add payment method "<method_2>"
		THEN "<method_1>" should be set to Dormant (Status D)
		AND "<method_2>" should be set to Active (A)
 
		Examples :
		| method_1  | method_2   |
		| Visa Card | Mastercard |
 
	@FEATURE_payment @FEATURE_update_method
	Scenario Outline: Set a payment method status as Active
		GIVEN I am an active customer
		AND I am verified as over 18
		AND I have a dormant payment method "<method_1>"
		AND I have an active payment method "<method_2>"
		WHEN I attempt to set  <method_1> as Active
		THEN "<method_1>" should be set to Active
		AND "<method_2>" should be set to Dormant

		Examples :
		| method_1   | method_2  |
		| Mastercard | Visa Card |

	@FEATURE_payment @FEATURE_update_method
	Scenario Outline: Remove an active card payment method with status A
		GIVEN I am an active customer
		AND I am verified as over 18
		AND I have an active credit card payment method
		WHEN I attempt to remove that payment method
		AND net deposits on the card are "<net_deposit_value>"
		THEN card payment method should be deleted (Status set to S)

		Examples :
		| net_deposit_value |
		| -10               |

	@FEATURE_payment @FEATURE_update_method
	Scenario Outline: Attempt to remove an eWallet payment method with status A
		GIVEN I am an active customer
		AND I am verified as over 18
		AND I have a dormant card payment method
		AND I have an active eWallet payment method
		WHEN I attempt to remove eWallet payment method
		AND net deposits on the card are "<net_deposit_value>"
		THEN <ewallet_method> should not be deleted

		Examples :
		| net_deposit_value |
		| 0                 |
		| -10               |

	@FEATURE_payment @FEATURE_update_method
	Scenario Outline: Attempt to remove an card payment method when net deposit > 0
		GIVEN I am an active customer
		AND I am verified as over 18
		AND I have an active card payment method
		WHEN I attempt to remove card payment method
		AND "<net_deposit_value>" on the card are > 0
		THEN the payment method should not be removed

		Examples :
		| net_deposit_value |
		| 10                |
		| 20                |

	@FEATURE_payment @FEATURE_update_method
	Scenario Outline: Remove a card method with status ‘D’
		GIVEN I am an active customer
		AND I am verified as over 18
		AND I have a Dormant card payment method
		AND I have an Active eWallet payment method
		WHEN I attempt to remove a card payment method (i.e. set status to S)
		AND net deposits on the card are "<net_deposit_value>"
		THEN card payment method should be deleted and status set to S

		Examples :
		| net_deposit_value|
		| 0                |
		| -10              |

	@FEATURE_payment @FEATURE_update_method
	Scenario Outline: Attempt a deposit using Removed method
		GIVEN I am an active customer
		AND I am verified as over 18
		AND I have a removed card payment method i.e. status set to S
		WHEN I attempt to make a deposit using removed card payment method
		THEN deposit attempt should be unsuccessful 
